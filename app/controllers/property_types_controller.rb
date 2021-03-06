class PropertyTypesController < ApplicationController
    def new
        @property_type = PropertyType.new
    end

    def create
        @property_type = PropertyType.new(params.require(:property_type).permit(:name))
        if @property_type.save
            redirect_to new_property_path
        else
            render :new
        end
    end

    def show
        @property_type = PropertyType.find(params[:id])
        @properties = @property_type.properties.all
    end
end