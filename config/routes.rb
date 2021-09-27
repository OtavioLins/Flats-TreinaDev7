Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: "home#index"
  resources :properties, only: [:show, :new, :create]
  resources :property_types, only: [:new, :create]
  resources :property_regions, only: [:new, :create]
end
