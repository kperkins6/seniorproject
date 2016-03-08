class Deck < ActiveRecord::Base
    has_many :businesscards
    belongs_to :user
end
