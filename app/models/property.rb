class Property < ApplicationRecord
    validates :title, :description, :rooms, :bathrooms, :daily_rate, 
    presence: {message: "ERRO: Para cadastrar um imóvel, todos os campos devem ser preenchidos."}
end
