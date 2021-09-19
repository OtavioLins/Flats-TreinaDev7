require 'rails_helper'

describe 'Visitor visits homepage' do
    it 'and view properties' do
        #Arrange (Preparar os Dados)
        Property.create({title: "Casa em Copacabana", 
                         description: "Excelente casa, recém reformada com 2 
                         vagas de garagem", rooms: 3})

        Property.create({title: "Cobertura em Manaus", 
                         description: "Cobertura de 300m2, churrasqueira e 
                         sauna privativa", rooms: 5})

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
end
