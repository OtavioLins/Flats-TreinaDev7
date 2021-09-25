require 'rails_helper'

describe "Visitor register property" do
    it 'successfully' do 
        #Arrange

        #Act
        visit root_path
        click_on "Cadastre seu imóvel aqui"
        fill_in 'Título', with: 'Casa em Florianópolis'
        fill_in 'Descrição do Imóvel', with: 'Ótima casa perto da UFSC'
        fill_in 'Número de Quartos', with: '3'
        fill_in 'Número de Banheiros', with: '2'
        fill_in 'Preço da Diária', with: '200'
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

    end
    
    it 'unsuccessfully' do 
        #Arrange
    
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
        click_on "Finalizar Cadastro"

        #Assert
        expect(page).to have_content("ERRO: Para cadastrar um imóvel, todos os campos devem ser preenchidos.")    
        expect(Property.count).to equal(0)
    end
end