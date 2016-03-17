class Tag < ActiveRecord::Base
    belongs_to :businesscard
    belongs_to :user
end
