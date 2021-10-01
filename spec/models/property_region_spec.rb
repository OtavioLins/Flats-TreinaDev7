require 'rails_helper'

describe PropertyRegion do
    context 'Validation' do
        it 'Name should be present' do
            propR = PropertyRegion.new
            propR.valid?
            expect(propR.errors.full_messages_for(:name)).to include
            ('Região não pode ficar em branco')
        end

        it 'Name is unique' do
            PropertyRegion.create!(name: 'Santos')
            propR = PropertyRegion.new(name: 'Santos')
            propR.valid?
            expect(propR.errors.full_messages_for(:name)).to include
            ('Região já está cadastrada')
        end
    end
end
