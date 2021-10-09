class PropertyReservationsController < ApplicationController
    def create
        @property_reservation = current_user.property_reservations.new(property_reservation_params)
        @property_reservation.property = Property.find(params[:property_id])
        @property_reservation.save!

        redirect_to @property_reservation, notice: t('.success')
    end

    def show
        @property_reservation = PropertyReservation.find(params[:id])
    end

    def property_reservation_params
        params.require(:property_reservation).permit(:start_date, :end_date, :guests_integer)
    end
end
