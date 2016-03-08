Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'users/sessions'
  }
  resources :tags
  resources :users
  resources :businesscards

  root 'home#index'
end
