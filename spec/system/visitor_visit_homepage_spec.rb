require 'rails_helper'

describe 'Visitor visit homepage' do
  it 'successfully' do
    visit root_path

    expect(page).to have_css('h1', text: 'Flats')
    expect(page).to have_css('h3', text: 'Boas vindas ao sistema de locação de '\
                                         'apartamentos')
  end

  it 'and tries to access locked routes' do
    visit new_property_path

    expect(page).to have_content('Para continuar, efetue login ou registre-se')
  end
end