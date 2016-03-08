class Tag < ActiveRecord::Base
    has_many :children, class_name: "Tag",
                        foreign_key: "parent_id",
                        inverse_of: tag
    
    belongs_to :parent, class_name: "Tag",
                        inverse_of: tags
end
