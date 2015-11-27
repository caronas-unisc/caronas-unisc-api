module Api
  module V1
    class MessagesController < ApplicationController
      before_action :check_session

      def index
        messages = Ride.find(ride_id).messages.includes(:user).where('id > ?', last_message_id)
        render json: messages
      end

      def create
        message = Ride.find(ride_id).messages.new(create_message_params)
        message.user = current_user

        if message.save
          render json: { message: message }
        else
          render json: message.errors, status: :unprocessable_entity
        end
      end

      private

      def ride_id
        params[:ride_id]
      end

      def last_message_id
        params[:last_id] || 0
      end

      def create_message_params
        params.require(:message).permit(:body)
      end
    end
  end
end