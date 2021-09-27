class PropertyRegionsController < ApplicationController
    def new
        @property_region = PropertyRegion.new
    end

    def create
        @property_region = PropertyRegion.new(params.require(:property_region).permit(:name))
        if @property_region.save
            redirect_to new_property_path
        else
            render :new
        end       
    end
end