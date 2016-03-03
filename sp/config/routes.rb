Rails.application.routes.draw do
    root 'home#index'

    get 'business_cards/index'

    get 'decks/index'

    get 'tag_cards/index'

    resources :tags, only: [:index, :show]
end
