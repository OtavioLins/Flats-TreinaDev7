class PropertiesController < ApplicationController
    def show
        @property = Property.find(params[:id])
    end

    def new
        @property = Property.new
    end

    def create
        prop = Property.create(params.require(:property).permit(:title, :description,
                               :rooms, :bathrooms, :pets, :parking_slot, :daily_rate))
        redirect_to property_path(prop)
    end
end