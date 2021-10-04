require 'rails_helper'

describe 'Property Owner authentication' do
    it 'cannot create property without being logged in' do
        post properties_path
        expect(response).to redirect_to(new_property_owner_session_path)
    end

    it 'cannot open form page without being logged in' do
        get new_property_path
        expect(response).to redirect_to(new_property_owner_session_path)
    end
end