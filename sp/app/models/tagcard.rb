class Tagcard < ActiveRecord::Base
    belongs_to :user
    belongs_to :businesscard
end
