class TagCard < ActiveRecord::Base
    belongs_to :user
    belongs_to :businesscard
    has_many :tags
end
