require 'rails_helper'

describe "Visitor register property" do
    it 'successfully' do 
        #Arrange
        PropertyType.create!(name: "Casa")
        PropertyRegion.create!(name: "Sudeste")

        #Act
        visit root_path
        click_on "Cadastre seu imóvel aqui"
        fill_in 'Título', with: 'Casa em Florianópolis'
        fill_in 'Descrição do Imóvel', with: 'Ótima casa perto da UFSC'
        fill_in 'Número de Quartos', with: '3'
        fill_in 'Número de Banheiros', with: '2'
        fill_in 'Preço da Diária', with: '200'
        select "Casa", from: "Tipo"
        select "Sudeste", from: "Região"
        check "Aceita Pets?"
        check "Vaga de Estacionamento"
        click_on "Finalizar Cadastro"

        #Assert
        expect(page).to have_content("Casa em Florianópolis")   
        expect(page).to have_content("Ótima casa perto da UFSC")     
        expect(page).to have_content("3")     
        expect(page).to have_content("2")     
        expect(page).to have_content("R$ 200,00")     
        expect(page).to have_content("Aceita pets: Sim")     
        expect(page).to have_content("Estacionamento: Sim")     
        expect(page).to have_content("Tipo: Casa")
        expect(page).to have_content("Região: Sudeste")
    end
    
    it 'and leave some spaces blank' do 
        #Arrange
        PropertyType.create!(name: "Casa")
        PropertyRegion.create!(name: "Sudeste")
    
        #Act
        visit root_path
        click_on "Cadastre seu imóvel aqui"
        fill_in 'Título', with: 'Casa em Florianópolis'
        fill_in 'Descrição do Imóvel', with: ''
        fill_in 'Número de Quartos', with: ''
        fill_in 'Número de Banheiros', with: ''
        fill_in 'Preço da Diária', with: '200'
        check "Aceita Pets?"
        check "Vaga de Estacionamento"
        select "Casa", from: "Tipo"
        select "Sudeste", from: "Região" 
        click_on "Finalizar Cadastro"

        #Assert
        expect(page).to have_content("Description não pode ficar em branco.")    
        expect(page).to have_content("Rooms não pode ficar em branco.")    
        expect(page).to have_content("Bathrooms não pode ficar em branco.")   
        expect(Property.count).to equal(0)
    end
end