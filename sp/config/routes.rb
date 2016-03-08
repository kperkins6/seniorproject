Rails.application.routes.draw do
  devise_for :users
  resources :users do
    resources :decks do
      resources :business_cards do
        resources :tags
      end
    end
  end

  root 'home#index'

end
