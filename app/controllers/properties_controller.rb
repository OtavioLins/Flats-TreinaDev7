class PropertiesController < ApplicationController
    before_action :authenticate_property_owner!, except: :show
    def show
        @property = Property.find(params[:id])
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
        if @property.save
            redirect_to @property
        else
            render :new
        end
    end
end