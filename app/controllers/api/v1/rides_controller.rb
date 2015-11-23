module Api
  module V1
    class RidesController < ApplicationController
      before_action :check_session

      def matches
        match_finder = MatchFinder.new(RideAvailability)
        receive_matches = match_finder.find_receive_matches_for_week(current_user, Date.current)
        give_matches = match_finder.find_give_matches_for_week(current_user, Date.current)

        render json: { receive: receive_matches, give: give_matches }
      end

      def create
        ride_availability = RideAvailability.give.find(params[:ride_availability_id])
        ride = ride_availability.create_pending_ride_for!(current_user)
        render json: ride
      end

      def update
        ride = Ride.where(giver_availability: { user: current_user }).find(params[:id])
        if ride.update(update_params)
          render json: ride
        else
          render json: ride.errors, status: :unprocessable_entity
        end
      end

      private

      def update_params
        params.require(:ride).permit(:status)
      end
    end
  end
end