require 'rails_helper'

describe 'Visitor visits homepage' do
    it 'and view properties' do
        #Arrange (Preparar os Dados)
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

        #Act (Executar a funcionalidade)
        visit root_path

        #Assert (Garantir que algo aconteceu ou não aconteceu)
        expect(page).to have_content('Apê na baixada Santista')
        expect(page).to have_content('Lugar familiar perfeito para curtir um fim de semana no litoral')
        expect(page).to have_content('Número de quartos: 2')

        expect(page).to have_content('Casa confortável no litoral')
        expect(page).to have_content('Casa aconchegante relativamente perto da praia')
        expect(page).to have_content('Número de quartos: 3')
    end

    it 'and there are no properties available' do
        visit root_path
        expect(page).to have_content('Nenhum imóvel disponível')
    end
    
    it 'and view property details' do
        ptype2 = PropertyType.create!(name: 'Casa')
        pregion1 = PropertyRegion.create!(name: 'Bertioga')
  
        Property.create!(title: 'Casa confortável no litoral', description: 'Casa aconchegante
            relativamente perto da praia', rooms:3, bathrooms: 2, pets: true, 
            parking_slot: true, daily_rate: 350, property_type: ptype2, 
            property_region: pregion1)

        visit root_path

        click_on 'Casa confortável no litoral'

        expect(page).to have_content('Casa confortável no litoral')
        expect(page).to have_content('Casa aconchegante relativamente perto da praia')
        expect(page).to have_content('Número de quartos: 3')
        expect(page).to have_content('Número de banheiros: 2')
        expect(page).to have_content('Aceita pets? Sim')
        expect(page).to have_content('Vaga de estacionamento? Sim')
        expect(page).to have_content('Preço da diária: R$ 350,00')
    end

    it 'and view property details and come back to home page' do
    #Arrange
    ptype2 = PropertyType.create!(name: 'Casa')
    pregion1 = PropertyRegion.create!(name: 'Bertioga')

    Property.create!(title: 'Casa confortável no litoral', description: 'Casa aconchegante
        relativamente perto da praia', rooms:3, bathrooms: 2, pets: true, 
        parking_slot: true, daily_rate: 350, property_type: ptype2, 
        property_region: pregion1)

    #Act
        visit root_path
        click_on 'Casa confortável no litoral'
        click_on 'Voltar'
    
    #Assert
        expect(current_path).to eq root_path
    end
end
