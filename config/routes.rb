Rails.application.routes.draw do
  resources :decks
  root "welcome#index"
end
