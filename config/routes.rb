Rails.application.routes.draw do
  root to: "sites#index"

  resources :users, except: [:new]
  get "/sign_up", to: "users#new"
  get "/profile", to: "users#profile"

  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/session", to: "sessions#destroy"

  resources :articles

end
