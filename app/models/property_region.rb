class PropertyRegion < ApplicationRecord
    has_many :properties
    
    validates :name, uniqueness: {message: 'já está cadastrada'}
    validates :name, presence: true
end
