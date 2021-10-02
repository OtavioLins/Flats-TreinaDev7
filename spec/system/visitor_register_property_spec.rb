require 'rails_helper'

describe 'Visitor register property' do
    it 'successfully' do 
        #Arrange
        PropertyType.create!(name: 'Apartamento')
        PropertyRegion.create!(name: 'Santos')
        property_owner = PropertyOwner.create!(email: 'jane@doe.com.br', password: '123456789')
        login_as property_owner, scope: :property_owner

        #Act
        visit root_path
        click_on 'Cadastre seu imóvel aqui'
        fill_in 'Título', with: 'Apê na baixada Santista'
        fill_in 'Descrição do imóvel', with: 'Lugar familiar perfeito para curtir um fim de semana no litoral'
        fill_in 'Número de quartos', with: '3'
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
        expect(page).to have_content('Número de quartos: 3')     
        expect(page).to have_content('Número de banheiros: 2')     
        expect(page).to have_content('R$ 200,00')     
        expect(page).to have_content('Aceita pets? Sim')     
        expect(page).to have_content('Vaga de estacionamento? Sim')     
        expect(page).to have_content('Tipo: Apartamento')
        expect(page).to have_content('Região: Santos')
    end
    
    it 'and leave some attributes blank' do 
        #Arrange
        PropertyType.create!(name: 'Apartamento')
        PropertyRegion.create!(name: 'Santos')
        property_owner = PropertyOwner.create!(email: 'jane@doe.com.br', password: '123456789')
        login_as property_owner, scope: :property_owner    
        #Act
        visit root_path
        click_on 'Cadastre seu imóvel aqui'
        fill_in 'Título', with: 'Apê na baixada Santista'
        fill_in 'Descrição do imóvel', with: ''
        fill_in 'Número de quartos', with: ''
        fill_in 'Número de banheiros', with: ''
        fill_in 'Preço da diária', with: '200'
        check 'Aceita pets?'
        check 'Vaga de estacionamento?'
        select 'Apartamento', from: 'Tipo'
        select 'Santos', from: 'Região' 
        click_on 'Finalizar cadastro'

        #Assert
        expect(page).to have_content('Descrição não pode ficar em branco')    
        expect(page).to have_content('Número de quartos não é um número')    
        expect(page).to have_content('Número de banheiros não é um número')   
        expect(Property.count).to equal(0)
    end
    it 'and tries to register wrong numerical values' do 
        #Arrange
        PropertyType.create!(name: 'Apartamento')
        PropertyRegion.create!(name: 'Santos')
        property_owner = PropertyOwner.create!(email: 'jane@doe.com.br', password: '123456789')
        login_as property_owner, scope: :property_owner    
        #Act
        visit root_path
        click_on 'Cadastre seu imóvel aqui'
        fill_in 'Título', with: 'Apê na baixada Santista'
        fill_in 'Descrição do imóvel', with: ''
        fill_in 'Número de quartos', with: '-2'
        fill_in 'Número de banheiros', with: '2.4'
        fill_in 'Preço da diária', with: '200.35'
        check 'Aceita pets?'
        check 'Vaga de estacionamento?'
        select 'Apartamento', from: 'Tipo'
        select 'Santos', from: 'Região' 
        click_on 'Finalizar cadastro'

        #Assert
        expect(page).to have_content('Número de quartos deve ser maior que 0')    
        expect(page).not_to have_content('Preço da diária deve ser um número inteiro')    
        expect(page).to have_content('Número de banheiros deve ser um número inteiro')   
        expect(Property.count).to equal(0)
    end
end