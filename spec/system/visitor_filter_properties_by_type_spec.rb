require 'rails_helper'

describe 'Visitor filter properties by type' do
    it 'should view links in nav bar' do
        #Arrange
        PropertyType.create!(name: 'Apartamento')
        PropertyType.create!(name: 'Casa')
        PropertyType.create!(name: 'Sítio')

        #Act
        visit root_path

        #Assert
        expect(page).to have_link('Apartamento')
        expect(page).to have_link('Casa')
        expect(page).to have_link('Sítio')
    end

    it 'successfully' do
        #Arrange
        ptype1 = PropertyType.create!(name: 'Apartamento')
        ptype2 = PropertyType.create!(name: 'Casa')
        pregion1 = PropertyRegion.create!(name: 'Bertioga')
        pregion2 = PropertyRegion.create!(name: 'Santos')
        Property.create!(title: 'Apê na baixada Santista', description: 'Lugar familiar
                         perfeito para curtir um fim de semana no litoral', rooms: 2,
                         bathrooms: 2, pets: true, parking_slot: true, daily_rate: 200,
                         property_type: ptype1, property_region: pregion2)
        Property.create!(title: 'Casa confortável no litoral', description: 'Casa aconchegante
                         relativamente perto da praia', rooms:3, bathrooms: 2, pets: true, 
                         parking_slot: true, daily_rate: 350, property_type: ptype2, 
                         property_region: pregion1)
        #Act
        visit root_path
        click_on 'Apartamento'
        #Assert
        expect(page).to have_link('Apê na baixada Santista')
        expect(page).not_to have_content('Casa confortável no litoral')
    end
end