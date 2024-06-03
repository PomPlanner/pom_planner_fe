Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  root "home#index"  # Assuming HomeController with an index action
  get "up" => "rails/health#show", as: :rails_health_check

  get '/auth/:provider/callback', to: 'sessions#omniauth'
  get '/auth/failure', to: redirect('/')
  delete '/logout', to: 'sessions#destroy', as: 'logout'

  resources :users, only: [:show]
  get '/users/:id/search', to: 'search#index'
  resources :search, only: [:index, :show]

  # Defines the root path route ("/")
  # root "posts#index"
end
