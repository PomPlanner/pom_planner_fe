Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  root "home#index"  # Assuming HomeController with an index action
  
  get '/users/:id', to: 'users#show', as: 'user'
  get '/auth/google_oauth2/callback', to: 'sessions#omniauth'
  get '/auth/failure', to: redirect('/')
  delete '/logout', to: 'sessions#destroy', as: 'logout'
  
  get '/users/:id/search', to: 'search#index', as: 'user_search'
  resources :search, only: [:show]
  
  get "up" => "rails/health#show", as: :rails_health_check
  # Defines the root path route ("/")
  # root "posts#index"
end
