Rails.application.routes.draw do
  root "welcome#index"
  get "spontaneous_event/show"

  resources :decks
end
