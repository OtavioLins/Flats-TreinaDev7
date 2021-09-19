require 'rails_helper'

describe 'Visitor visits homepage' do
    it 'and view properties' do
        #Arrange (Preparar os Dados)
        Property.create({title: "Casa em Copacabana", 
                         description: "Excelente casa, recém reformada com 2 
                         vagas de garagem", rooms: 3, parking_slot: true, bathrooms: 2,
                         pets: true, daily_rate: 500})

        Property.create({title: "Cobertura em Manaus", 
                         description: "Cobertura de 300m2, churrasqueira e 
                         sauna privativa", rooms: 5, parking_slot: false, bathrooms: 3,
                         pets: false, daily_rate: 750})

        #Act (Executar a funcionalidade)
        visit root_path

        #Assert (Garantir que algo aconteceu ou não aconteceu)
        expect(page).to have_text("Casa em Copacabana")
        expect(page).to have_text("Excelente casa, recém reformada com 2 vagas de garagem")
        expect(page).to have_text("Quartos: 3")

        expect(page).to have_text("Cobertura em Manaus")
        expect(page).to have_text("Cobertura de 300m2, churrasqueira e sauna privativa")
        expect(page).to have_text("Quartos: 5")
    end

    it 'and there are no properties available' do
        visit root_path
        expect(page).to have_text("Nenhum imóvel disponível")
    end
    
    it 'and view property details' do
        Property.create({title: "Casa em Copacabana", 
                        description: "Excelente casa, recém reformada com 2 
                        vagas de garagem", rooms: 3, parking_slot: true, bathrooms: 2,
                        pets: true, daily_rate: 500})
        
        visit root_path

        click_on "Casa em Copacabana"

        expect(page).to have_text("Casa em Copacabana")
        expect(page).to have_text("Excelente casa, recém reformada com 2 vagas de garagem")
        expect(page).to have_text("Quartos: 3")
        expect(page).to have_text("Banheiros: 2")
        expect(page).to have_text("Aceita pets: Sim")
        expect(page).to have_text("Estacionamento: Sim")
    end
end
