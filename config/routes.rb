Rails.application.routes.draw do
  devise_for :users, path: 'users'
  devise_for :property_owners, path: 'property_owners'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: "home#index"
  resources :properties, only: [:show, :new, :create] do
    collection do
      get 'my_properties'
    end
  end
  resources :property_types, only: [:show, :new, :create]
  resources :property_regions, only: [:show, :new, :create]
  resources :property_reservations, only: [:create]
end
