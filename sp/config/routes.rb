Receta::Application.routes.draw do
    root 'home#index'

    get 'business_cards/index'

    get 'decks/index'

    get 'tag_cards/index'

    get 'tags/index'

    resources :tags, only: [:index]
end
