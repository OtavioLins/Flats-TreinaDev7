require 'rails_helper'

describe "Visitor register property region" do
    it 'successfully' do 
        #Arrange
        PropertyType.create!(name: "Casa")

        #Act
        visit root_path
        click_on "Cadastre seu imóvel aqui"
        click_on "Caso precise adicionar uma nova região, clique aqui"
        fill_in 'Região', with: "Sul"
        click_on "Voltar ao cadastro"
        fill_in 'Título', with: 'Casa em Florianópolis'
        fill_in 'Descrição do Imóvel', with: 'Ótima casa perto da UFSC'
        fill_in 'Número de Quartos', with: '3'
        fill_in 'Número de Banheiros', with: '2'
        fill_in 'Preço da Diária', with: '200'
        select "Casa", from: "Tipo"
        select "Sul", from: "Região"
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
        expect(page).to have_content("Região: Sul")
    end
    
    it "and leave 'name' blank" do
        #Arrange
        PropertyType.create!(name: "Apartamento")
        #Act
        visit root_path
        click_on "Cadastre seu imóvel aqui"
        click_on "Caso precise adicionar uma nova região, clique aqui"
        click_on "Voltar ao cadastro"
        #Assert
        expect(page).to have_content("Name can't be blank")
    end

    it "and register a name that's already done" do
        #Arrange
        PropertyRegion.create!(name: "Sudeste")
        PropertyType.create!(name: "Apartamento")
        #Act
        visit root_path
        click_on "Cadastre seu imóvel aqui"
        click_on "Caso precise adicionar uma nova região, clique aqui"
        fill_in 'Região', with: "Sudeste"
        click_on "Voltar ao cadastro"
        #Assert
        expect(page).to have_content("Name has already been taken")
    end
end