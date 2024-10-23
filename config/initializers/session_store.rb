Rails.application.config.session_store :cookie_store, 
  key: '_your_app_session', 
  domain: 'pom-planner-6a8ebbf9e5c1.herokuapp.com', 
  tld_length: 2, 
  secure: Rails.env.production?, 
  same_site: :none, 
  expire_after: 7.days
