require 'rails_helper'

describe Property do
    context 'Validation' do
        it 'attributes must be present' do
            property = Property.new
            property.valid?
            expect(property.errors.full_messages_for(:title)).to include(
            'Título não pode ficar em branco')
            expect(property.errors.full_messages_for(:description)).to include(
            'Descrição não pode ficar em branco')
            expect(property.errors.full_messages_for(:rooms)).to include(
            'Número de quartos não pode ficar em branco')
            expect(property.errors.full_messages_for(:bathrooms)).to include(
            'Número de banheiros não pode ficar em branco')
            expect(property.errors.full_messages_for(:daily_rate)).to include(
            'Preço da diária não pode ficar em branco')
            expect(property.errors.full_messages_for(:property_type)).to include(
            'Tipo de imóvel é obrigatório(a)')
            expect(property.errors.full_messages_for(:property_region)).to include(
            'Região do imóvel é obrigatório(a)')
        end

        it 'Numerical values must be valid' do
            
        end
        
    end
end
