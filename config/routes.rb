Rails.application.routes.draw do
  root "decks#index"
  get "spontaneous_event/show"

  resources :decks
end
