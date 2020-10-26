Rails.application.routes.draw do
  root "decks#index"

  resources :sessions, only: [:new, :create, :destroy]
  resources :users

  resources :decks

  get "spontaneous_event/show" # TODO: resourcify
  get "/auth/:provider/callback", to: "omniauth_sessions#create"
  post "/auth/:provider/callback", to: "omniauth_sessions#dev_create"
end
