class Deck < ActiveRecord::Base
    has_many :business_cards, inverse_of: :deck
    belongs_to :user, inverse_of: :decks
end
