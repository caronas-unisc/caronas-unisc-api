module Api
  module V1
    class SessionsController < ApplicationController
      def create
        user = User.find_by(email: params[:email])
        if user && user.authenticate(params[:password])
          session = user.create_session
          render json: session
        else
          render text: 'Access Denied', status: :unauthorized
        end
      end

      def destroy
        @session = Session.find_by(token: params[:id])
        @session.destroy
        head :no_content
      end
    end
  end
end