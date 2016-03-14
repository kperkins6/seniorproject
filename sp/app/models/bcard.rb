class Bcard < ActiveRecord::Base
    belongs_to :user, dependent: :destroy
    has_many :tags
end
