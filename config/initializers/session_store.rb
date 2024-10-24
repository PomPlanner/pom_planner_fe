Rails.application.config.session_store :cookie_store, 
  key: '_your_app_session',      # Ensure this key matches with the frontend
  domain: :all,                  # Allow cookies to be shared across subdomains
  # tld_length: 2,                 # Adjust if your domain structure has more levels
  same_site: :none,              # SameSite None is needed for cross-domain cookies
  secure: Rails.env.production?, # Use HTTPS in production environments
  httponly: true                 # Extra security to prevent JavaScript access to cookies
