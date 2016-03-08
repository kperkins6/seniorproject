Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'users/sessions'
  }
  resources :users
  resources :decks
  resources :businesscards
  resources :tags
  root 'home#index'
end
