module Api
  module V1
    class PasswordResetsController < ApplicationController
      def create
        user = User.find_by_email(params[:email]) if params[:email]
        user.send_password_reset if user
        render json: { status: "ok" }
      end
    end
  end
end