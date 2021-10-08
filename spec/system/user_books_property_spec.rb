require 'rails_helper'

describe 'user books a property' do
    it 'successfully' do
        otavio = PropertyOwner.create!(email: 'jane@doe.com.br', password: '123456789')
        ptype1 = PropertyType.create!(name: 'Apartamento')
        pregion2 = PropertyRegion.create!(name: 'Santos')
        Property.create!(title: 'Apê na baixada Santista', description: 'Lugar familiar
                         perfeito para curtir um fim de semana no litoral', rooms: 2,
                         bathrooms: 2, pets: true, parking_slot: true, daily_rate: 200,
                         property_type: ptype1, property_region: pregion2, property_owner: otavio)
        
        user = User.create!(email: 'otavio@user.com.br', password: '123456789')
        
        login_as user, scope: :user
        visit root_path
        click_on 'Apê na baixada Santista'
        fill_in 'Data de início', with: '06/10/2021'
        fill_in 'Data de término', with: '10/10/2021'
        fill_in 'Quantidade de pessoas', with: 3
        click_on 'Enviar reserva'

        expect(page).to have_content('06/10/2021')
        expect(page).to have_content('10/10/2021')
        expect(page).to have_content(/3/)
        expect(page).to have_content('R$ 800,00')
        expect(page).to have_content('Pedido de reserva enviado com sucesso')
    end
end