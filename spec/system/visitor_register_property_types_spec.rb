require 'rails_helper'

describe "Visitor register property type" do
    it 'successfully' do
        #Arrange
        
        #Act
        visit root_path
        click_on "Cadastrar tipo de Imóvel"
        fill_in 'Nome', with: 'Casa'
        click_on 'Finalizar Cadastro'

        #Assert
        expect(page).to have_content("Casa")
        expect(PropertyType.count).to equal(1)
    end

    it 'unsuccessfully' do
        #Arrange
        
        #Act
        visit root_path
        click_on "Cadastrar tipo de Imóvel"
        click_on 'Finalizar Cadastro'

        #Assert
        expect(page).to have_content("Name can't be blank")
        expect(PropertyType.count).to equal(0)
    end

    it 'unsuccessfully' do
        #Arrange
        PropertyType.create({name: 'Casa'})

        #Act
        visit root_path
        click_on "Cadastrar tipo de Imóvel"
        fill_in 'Nome', with: "Casa"
        click_on 'Finalizar Cadastro'

        #Assert
        expect(page).to have_content("Name has already been taken")
        expect(PropertyType.count).to equal(1)
    end
end