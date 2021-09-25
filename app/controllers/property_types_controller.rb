class PropertyTypesController < ApplicationController
    def new
        @property_type = PropertyType.new
    end

    def create
        @property_type = PropertyType.new(params.require(:property_type).permit(:name))
        if @property_type.save
            redirect_to new_property_type_path
        else
            render :new
        end
    end

end