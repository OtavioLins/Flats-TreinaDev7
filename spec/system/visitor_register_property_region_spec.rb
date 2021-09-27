require 'rails_helper'

describe "Visitor register property type" do
    it 'successfully' do
        #Arrange
        
        #Act
        visit root_path
        click_on "Cadastrar região do Imóvel"
        fill_in 'Nome', with: 'Sudeste'
        click_on 'Finalizar Cadastro'

        #Assert
        expect(page).to have_content("Sudeste")
        expect(PropertyRegion.count).to equal(1)
    end

    it 'unsuccessfully' do
        #Arrange
        
        #Act
        visit root_path
        click_on "Cadastrar região do Imóvel"
        click_on 'Finalizar Cadastro'

        #Assert
        expect(page).to have_content("Name can't be blank")
        expect(PropertyRegion.count).to equal(0)
    end

    it 'unsuccessfully' do
        #Arrange
        PropertyRegion.create({name: 'Sudeste'})

        #Act
        visit root_path
        click_on "Cadastrar região do Imóvel"
        fill_in 'Nome', with: "Sudeste"
        click_on 'Finalizar Cadastro'

        #Assert
        expect(page).to have_content("Name has already been taken")
        expect(PropertyRegion.count).to equal(1)
    end
end