require 'rails_helper'

describe PropertyRegion do
    context 'Validation' do
        it 'Name should be present' do
            propR = PropertyType.new
            propR.valid?
            expect(propR.errors.full_messages_for(:name)).to include
            ('Tipo não pode ficar em branco')
        end

        it 'Name is unique' do
            PropertyRegion.create!(name: 'Casa')
            propR = PropertyRegion.new(name: 'Casa')
            propR.valid?
            expect(propR.errors.full_messages_for(:name)).to include
            ('Tipo já está cadastrado')
        end
    end
end
