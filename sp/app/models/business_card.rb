class BusinessCard < ActiveRecord::Base
    belongs_to :user, dependent: :destroy, inverse_of: :businesscard
    has_many :tag_cards, dependent: :destroy
    has_many :tags, through: :tag_cards
end
