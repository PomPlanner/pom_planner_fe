# syntax = docker/dockerfile:1

# Make sure RUBY_VERSION matches the Ruby version in .ruby-version and Gemfile
ARG RUBY_VERSION=3.2.2
FROM registry.docker.com/library/ruby:$RUBY_VERSION-slim AS base


# Set working directory
WORKDIR /rails

# Set production environment
ENV RAILS_ENV="production" \
    BUNDLE_DEPLOYMENT="1" \
    BUNDLE_PATH="/usr/local/bundle" \
    BUNDLE_WITHOUT="development test"

# Throw-away build stage to reduce size of final image
FROM base AS build

# Install system dependencies for building gems and assets
RUN apt-get update -qq && \
    apt-get install --no-install-recommends -y build-essential git libpq-dev libvips pkg-config curl nodejs npm

# Install Yarn from npm (since we now have npm installed)
RUN npm install -g yarn

# Install application gems
COPY Gemfile Gemfile.lock ./
RUN bundle install && \
    rm -rf ~/.bundle/ "${BUNDLE_PATH}"/ruby/*/cache "${BUNDLE_PATH}"/ruby/*/bundler/gems/*/.git && \
    bundle exec bootsnap precompile --gemfile

# Copy application code
COPY . .

# Install JavaScript dependencies
RUN yarn install --check-files

# Precompile bootsnap code for faster boot times (optional)
RUN bundle exec bootsnap precompile app/ lib/

# Final stage for the app image
FROM base

# Install Node.js and Yarn in the final image
RUN apt-get update -qq && \
    apt-get install --no-install-recommends -y curl libvips postgresql-client nodejs npm

# Install Yarn globally
RUN npm install -g yarn

# Copy built artifacts: gems, application code
COPY --from=build /usr/local/bundle /usr/local/bundle
COPY --from=build /rails /rails

# Run as a non-root user for security
RUN useradd rails --create-home --shell /bin/bash && \
    chown -R rails:rails db log storage tmp
USER rails:rails

# Entrypoint prepares the database (optional, if needed by your app)
ENTRYPOINT ["/rails/bin/docker-entrypoint"]

# Expose the web server port
EXPOSE 3000

# Start the server by default, this can be overwritten at runtime
CMD ["sh", "-c", "./bin/rails server -b 0.0.0.0 -p ${PORT}"]



