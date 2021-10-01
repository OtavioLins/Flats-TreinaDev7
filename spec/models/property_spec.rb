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
            'Número de quartos não é um número')
            expect(property.errors.full_messages_for(:bathrooms)).to include(
            'Número de banheiros não é um número')
            expect(property.errors.full_messages_for(:daily_rate)).to include(
            'Preço da diária não é um número')
            expect(property.errors.full_messages_for(:property_type)).to include(
            'Tipo de imóvel é obrigatório(a)')
            expect(property.errors.full_messages_for(:property_region)).to include(
            'Região do imóvel é obrigatório(a)')
        end

        it 'Numerical values rooms and bathrooms must be integers' do
            property = Property.new(rooms: 2.5, bathrooms: 9.6, daily_rate: 450.3)
            property.valid?
            expect(property.errors.full_messages_for(:rooms)).to include(
            'Número de quartos deve ser um número inteiro')
            expect(property.errors.full_messages_for(:bathrooms)).to include(
            'Número de banheiros deve ser um número inteiro')
        end

        it 'Numerical values rooms, bathrooms and daily_rate must be greater than 0' do
            property = Property.new(rooms: 0, bathrooms: -1, daily_rate: -41.9)
            property.valid?
            expect(property.errors.full_messages_for(:rooms)).to include(
            'Número de quartos deve ser maior que 0')
            expect(property.errors.full_messages_for(:bathrooms)).to include(
            'Número de banheiros deve ser maior que 0')
            expect(property.errors.full_messages_for(:daily_rate)).not_to include(
            'Preço da diária deve ser um número inteiro')
            expect(property.errors.full_messages_for(:daily_rate)).to include(
            'Preço da diária deve ser maior que 0')
        end
    end
end
