module Api
  module V1
    class RideAvailabilitiesController < ApplicationController
      before_action :check_session
      before_action :set_ride_availability

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
          :starting_location_longitude)
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