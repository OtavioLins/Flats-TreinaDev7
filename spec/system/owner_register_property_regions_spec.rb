require 'rails_helper'

describe 'Owner register property region' do
    it 'successfully' do 
        #Arrange
        PropertyType.create!(name: 'Apartamento')
        property_owner = PropertyOwner.create!(email: 'jane@doe.com.br', password: '123456789')
        login_as property_owner, scope: :property_owner
        #Act
        visit root_path
        click_on 'Cadastre seu imóvel aqui'
        click_on 'Caso precise adicionar uma nova região, clique aqui'
        fill_in 'Região', with: 'Santos'
        click_on 'Voltar ao cadastro'
        fill_in 'Título', with: 'Apê na baixada Santista'
        fill_in 'Descrição do imóvel', with: 'Lugar familiar perfeito para curtir um fim de semana no litoral'
        fill_in 'Número de quartos', with: '2'
        fill_in 'Número de banheiros', with: '2'
        fill_in 'Preço da diária', with: '200'
        select 'Apartamento', from: 'Tipo'
        select 'Santos', from: 'Região'
        check 'Aceita pets?'
        check 'Vaga de estacionamento?'
        click_on 'Finalizar cadastro'

        #Assert
        expect(page).to have_content('Apê na baixada Santista')   
        expect(page).to have_content('Lugar familiar perfeito para curtir um fim de semana no litoral')     
        expect(page).to have_content('Número de quartos: 2')     
        expect(page).to have_content('Número de banheiros: 2')     
        expect(page).to have_content('R$ 200,00')     
        expect(page).to have_content('Aceita pets? Sim')     
        expect(page).to have_content('Vaga de estacionamento? Sim')     
        expect(page).to have_content('Tipo: Apartamento')
        expect(page).to have_content('Região: Santos')
    end
    
    it "and leave 'name' field blank" do
        #Arrange
        property_owner = PropertyOwner.create!(email: 'jane@doe.com.br', password: '123456789')
        login_as property_owner, scope: :property_owner
        #Act
        visit root_path
        click_on 'Cadastre seu imóvel aqui'
        click_on 'Caso precise adicionar uma nova região, clique aqui'
        click_on 'Voltar ao cadastro'
        #Assert
        expect(page).to have_content('Região não pode ficar em branco')
    end

    it 'and tries to register a region thats already registered' do
        #Arrange
        property_owner = PropertyOwner.create!(email: 'jane@doe.com.br', password: '123456789')
        login_as property_owner, scope: :property_owner
        PropertyRegion.create!(name: 'Santos')
        #Act
        visit root_path
        click_on 'Cadastre seu imóvel aqui'
        click_on 'Caso precise adicionar uma nova região, clique aqui'
        fill_in 'Região', with: 'Santos'
        click_on 'Voltar ao cadastro'
        #Assert
        expect(page).to have_content('Região já está cadastrada')
    end
end