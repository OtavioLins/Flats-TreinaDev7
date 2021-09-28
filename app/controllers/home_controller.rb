class HomeController < ApplicationController
    def index
        @properties = Property.all
        @property_types = PropertyType.all
        @property_regions = PropertyRegion.all
    end
end