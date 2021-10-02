require 'rails_helper'

describe 'visitor logs in' do
    context 'property owner' do
        it 'successfully' do
            property_owner = PropertyOwner.create!(email: 'jane@doe.com.br', password: '123456789')

            visit root_path
            click_on 'Entrar'
            fill_in 'Email', with: property_owner.email
            fill_in 'Senha', with: property_owner.password
            within 'form' do
                click_on 'Entrar'
            end

            expect(page).to have_content('Login efetuado com sucesso!')
            expect(page).to have_content(property_owner.email)
            expect(page).to have_link('Logout')
            expect(page).not_to have_link('Entrar')
            expect(page).to have_link('Cadastre seu imóvel aqui')
        end

        it 'and logs out' do
            property_owner = PropertyOwner.create!(email: 'jane@doe.com.br', password: '123456789')
            login_as property_owner, scope: :property_owner
            visit root_path
            click_on 'Logout'
            
            expect(page).to have_content('Saiu com sucesso')
            expect(page).not_to have_link('Logout')
            expect(page).to have_link('Entrar')
            expect(page).not_to have_link('Cadastre seu imóvel aqui')
            expect(page).not_to have_content(property_owner.email)

        end

        it 'and create an account' do
        
        end
    end
end