Rails.application.routes.draw do
  resources :bcards
  devise_for :users, controllers: {
    sessions: 'users/sessions'
  }
  resources :users
  resources :decks
  resources :businesscards
  resources :tags
  resources :tagcards
  root 'home#index'
end
