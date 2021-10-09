class PropertiesController < ApplicationController
    before_action :authenticate_property_owner!, only: [:new, :create]
    def show
        @property = Property.find(params[:id])
        @property_reservation = PropertyReservation.new
    end

    def new
        @property = Property.new
        @property_types = PropertyType.all
        @property_regions = PropertyRegion.all
    end

    def create
        @property_types = PropertyType.all
        @property_regions = PropertyRegion.all
        @property = Property.new(params.require(:property).permit(:title, :description,
                               :rooms, :bathrooms, :pets, :parking_slot, :daily_rate, 
                               :property_type_id, :property_region_id))
        @property.property_owner = current_property_owner
        if @property.save
            redirect_to @property
        else
            render :new
        end
    end

    def my_properties
        @properties = current_property_owner.properties
    end
end