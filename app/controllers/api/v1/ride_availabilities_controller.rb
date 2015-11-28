module Api
  module V1
    class RideAvailabilitiesController < ApplicationController
      before_action :check_session
      before_action :set_ride_availability, only: [:update, :destroy]

      def show_for_week
        ride_availabilities = RideAvailability.get_for_week(current_user, date).order('date ASC, period ASC')
        render json: ride_availabilities
      end

      def repeat_last_week
        ride_availabilities = RideAvailability.repeat_last_week!(current_user)
        render json: ride_availabilities
      end

      def update
        @ride_availability.assign_attributes(ride_availability_params)

        if @ride_availability.save()
          render json: @ride_availability
        else
          render json: @ride_availability.errors, status: :unprocessable_entity
        end
      end

      def destroy
        @ride_availability.destroy if @ride_availability
        render json: { status: "ok" }
      end

      private

      def set_ride_availability
        @ride_availability = RideAvailability.find_or_initialize_by(
          user: current_user,
          date: date,
          period: RideAvailability.periods[period]
        )
      end

      def ride_availability_params
        params.require(:ride_availability).permit(:availability_type,
          :starting_location_address, :starting_location_latitude,
          :starting_location_longitude, :available_places_in_car)
      end

      def date
        params[:date].to_date
      end

      def period
        params[:period]
      end
    end
  end
end