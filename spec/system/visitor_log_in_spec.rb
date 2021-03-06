require 'rails_helper'

describe 'visitor logs in' do
    context 'property owner' do
        it 'successfully' do
            property_owner = PropertyOwner.create!(email: 'jane@doe.com.br', password: '123456789')

            visit root_path
            click_on 'Entrar como proprietário'
            fill_in 'Email', with: property_owner.email
            fill_in 'Senha', with: property_owner.password
            click_on 'Entrar'

            expect(page).to have_content('Login efetuado com sucesso!')
            expect(page).to have_content(property_owner.email)
            expect(page).to have_link('Sair')
            expect(page).to have_link('Meus imóveis')
            expect(page).not_to have_link('Entrar como proprietário')
            expect(page).to have_link('Cadastre seu imóvel aqui')
        end

        it 'and logs out' do
            property_owner = PropertyOwner.create!(email: 'jane@doe.com.br', password: '123456789')
            login_as property_owner, scope: :property_owner
            visit root_path
            click_on 'Sair'
            
            expect(page).to have_content('Saiu com sucesso')
            expect(page).not_to have_link('Sair')
            expect(page).to have_link('Entrar como proprietário')
            expect(page).not_to have_link('Cadastre seu imóvel aqui')
            expect(page).not_to have_content(property_owner.email)

        end

        it 'and create an account' do
            visit root_path
            click_on 'Entrar como proprietário'
            click_on 'Se cadastre aqui'
            fill_in 'Email', with: 'jane@doe.com.br'
            fill_in 'Senha', with: 'asf589'
            fill_in 'Confirme sua senha', with: 'asf589'
            click_on 'Finalizar cadastro'

            expect(current_path).to eq(root_path)
            expect(page).to have_content('jane@doe.com.br')
            expect(page).to have_link('Sair')
            expect(page).to have_link('Meus imóveis')
            expect(page).to have_link('Cadastre seu imóvel aqui')
            expect(page).not_to have_link('Entrar como proprietário')
        end
    end
    context 'User' do
        it 'successfully' do
            user = User.create!(email: 'jane@doe.com.br', password: '123456789')

            visit root_path
            click_on 'Entrar como usuário'
            fill_in 'Email', with: user.email
            fill_in 'Senha', with: user.password
            click_on 'Entrar'
            

            expect(page).to have_content('Login efetuado com sucesso!')
            expect(page).to have_content(user.email)
            expect(page).to have_link('Sair')
            expect(page).not_to have_link('Entrar como usuário')
            expect(page).not_to have_link('Cadastre seu imóvel aqui')            
        end
        it 'and logs out' do
            user = User.create!(email: 'jane@user.com.br', password: '123456789')
            login_as user, scope: :user
            visit root_path
            click_on 'Sair'
            
            expect(page).to have_content('Saiu com sucesso')
            expect(page).not_to have_link('Sair')
            expect(page).to have_link('Entrar como proprietário')
            expect(page).to have_link('Entrar como usuário')
            expect(page).not_to have_link('Cadastre seu imóvel aqui')
            expect(page).not_to have_content(user.email)

        end

        it 'and create an account' do
            visit root_path
            click_on 'Entrar como usuário'
            click_on 'Se cadastre aqui'
            fill_in 'Email', with: 'jane@user.com.br'
            fill_in 'Senha', with: 'asf589'
            fill_in 'Confirme sua senha', with: 'asf589'
            click_on 'Finalizar cadastro'

            expect(current_path).to eq(root_path)
            expect(page).to have_content('jane@user.com.br')
            expect(page).to have_link('Sair')
            expect(page).not_to have_link('Cadastre seu imóvel aqui')
            expect(page).not_to have_link('Entrar como proprietário')
            expect(page).not_to have_link('Entrar como usuário')
        end
    end
end