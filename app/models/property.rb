class Property < ApplicationRecord
    belongs_to :property_type
    belongs_to :property_region
    belongs_to :property_owner
    
    validates :title, :description, presence: true
    validates :rooms, :bathrooms, numericality: {message: "deve ser um número inteiro", only_integer: true}
    validates :rooms, :bathrooms, :daily_rate, numericality: {greater_than: 0}
end
