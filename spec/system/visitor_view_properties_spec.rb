require 'rails_helper'

describe 'Visitor visits homepage' do
    it 'and view properties' do
        #Arrange (Preparar os Dados)
        property_type = PropertyType.create!(name: "Casa")
        property_region = PropertyRegion.create!(name: "Sudeste")
        Property.create!({title: "Casa em Copacabana", 
                         description: "Excelente casa, recém reformada com 2 
                         vagas de garagem", rooms: 3, parking_slot: true, bathrooms: 2,
                         pets: true, daily_rate: 500, property_type_id: property_type.id, 
                         property_region_id: property_region.id})

        Property.create!({title: "Cobertura em Manaus", 
                         description: "Cobertura de 300m2, churrasqueira e 
                         sauna privativa", rooms: 5, parking_slot: false, bathrooms: 3,
                         pets: false, daily_rate: 750, property_type_id: property_type.id,
                         property_region_id: property_region.id})

        #Act (Executar a funcionalidade)
        visit root_path

        #Assert (Garantir que algo aconteceu ou não aconteceu)
        expect(page).to have_content("Casa em Copacabana")
        expect(page).to have_content("Excelente casa, recém reformada com 2 vagas de garagem")
        expect(page).to have_content("Quartos: 3")

        expect(page).to have_content("Cobertura em Manaus")
        expect(page).to have_content("Cobertura de 300m2, churrasqueira e sauna privativa")
        expect(page).to have_content("Quartos: 5")
    end

    it 'and there are no properties available' do
        visit root_path
        expect(page).to have_content("Nenhum imóvel disponível")
    end
    
    it 'and view property details' do
        property_type = PropertyType.create!(name: "Casa")
        property_region = PropertyRegion.create!(name: "Sudeste")
  
        Property.create!({title: "Casa em Copacabana", 
                        description: "Excelente casa, recém reformada com 2 
                        vagas de garagem", rooms: 3, parking_slot: true, bathrooms: 2,
                        pets: true, daily_rate: 500, property_type_id: property_type.id,
                        property_region_id: property_region.id})
        
        visit root_path

        click_on "Casa em Copacabana"

        expect(page).to have_content("Casa em Copacabana")
        expect(page).to have_content("Excelente casa, recém reformada com 2 vagas de garagem")
        expect(page).to have_content("Quartos: 3")
        expect(page).to have_content("Banheiros: 2")
        expect(page).to have_content("Aceita pets: Sim")
        expect(page).to have_content("Estacionamento: Sim")
        expect(page).to have_content("Preço da diária: R$ 500,00")
    end

    it 'and view property details and come back to home page' do
    #Arrange
        property_type = PropertyType.create!(name: "Casa")
        property_region = PropertyRegion.create!(name: "Sudeste")

        Property.create!({title: "Casa em Copacabana", 
                        description: "Excelente casa, recém reformada com 2 
                        vagas de garagem", rooms: 3, parking_slot: true, bathrooms: 2,
                        pets: true, daily_rate: 500, property_type_id: property_type.id,
                        property_region_id: property_region.id})

        Property.create!({title: "Cobertura em Manaus", 
                        description: "Cobertura de 300m2, churrasqueira e 
                        sauna privativa", rooms: 5, parking_slot: false, bathrooms: 3,
                        pets: false, daily_rate: 750, property_type_id: property_type.id, 
                        property_region_id: property_region.id})
    #Act
        visit root_path
        click_on "Cobertura em Manaus"
        click_on 'Voltar'
    
    #Assert
        expect(current_path).to eq root_path
    end
end
