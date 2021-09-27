class PropertyType < ApplicationRecord
    has_many :properties
    
    validates :name, uniqueness: true
    validates :name, presence: true
end
