require 'rails_helper'

describe 'Property Owner view own properties' do
    it 'Using menu' do
        #Arrange
        property_owner = PropertyOwner.create!(email: 'jane@doe.com.br', password: '123456789')

        #Act
        login_as property_owner, scope: :property_owner
        visit root_path
        
        #Assert
        expect(page).to have_link('Meus imóveis')
    end

    it 'and should view owned properties' do
        #Arrange
        otavio = PropertyOwner.create!(email: 'jane@doe.com.br', password: '123456789')
        lucas = PropertyOwner.create!(email: 'lucas@perez.com.br', password: '123456789')
        ptype1 = PropertyType.create!(name: 'Apartamento')
        ptype2 = PropertyType.create!(name: 'Casa')
        pregion1 = PropertyRegion.create!(name: 'Bertioga')
        pregion2 = PropertyRegion.create!(name: 'Santos')
        Property.create!(title: 'Apê na baixada Santista', description: 'Lugar familiar
                         perfeito para curtir um fim de semana no litoral', rooms: 2,
                         bathrooms: 2, pets: true, parking_slot: true, daily_rate: 200,
                         property_type: ptype1, property_region: pregion2, property_owner: otavio)
        Property.create!(title: 'Casa confortável no litoral', description: 'Casa aconchegante
                         relativamente perto da praia', rooms:3, bathrooms: 2, pets: true, 
                         parking_slot: true, daily_rate: 350, property_type: ptype2, 
                         property_region: pregion1, property_owner: lucas)
        #Act
        login_as otavio, scope: :property_owner
        visit root_path
        click_on 'Meus imóveis'
        
        #Assert

        expect(page).to have_content('Apê na baixada Santista')
        expect(page).not_to have_content('Casa confortável no litoral')
        
    end

    it 'and has no properties' do
        otavio = PropertyOwner.create!(email: 'jane@doe.com.br', password: '123456789')

        login_as otavio, scope: :property_owner
        visit root_path
        click_on 'Meus imóveis'
 
        expect(page).to have_content('Nenhum imóvel cadastrado')
        expect(page).to have_link('clique aqui para cadastrar um imóvel')
    end
end