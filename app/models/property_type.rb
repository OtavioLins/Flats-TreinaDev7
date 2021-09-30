class PropertyType < ApplicationRecord
    has_many :properties
    
    validates :name, uniqueness: {message: 'já está cadastrado'}
    validates :name, presence: true
end
