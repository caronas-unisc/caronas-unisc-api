module Api
  module V1
    class UsersController < ApplicationController
      before_action :check_session, only: [:update]

      def index
        users = User.all
        render json: users
      end

      def create
        user = User.new(create_user_params)

        if user.save
          render json: { user: user, session: user.create_session }
        else
          render json: user.errors, status: :unprocessable_entity
        end
      end

      def update
        user = current_user
        if user.update(update_user_params)
          render json: user
        else
          render json: user.errors, status: :unprocessable_entity
        end
      end

      private

      def create_user_params
        params.require(:user).permit(:name, :email, :password, :ride_intention)
      end

      def update_user_params
        params.require(:user).permit(:name, :password, :ride_intention)
      end
    end
  end
end