module Api
  module V1
    class NotificationsController < ApplicationController
      before_action :check_session

      def index
        notifications = current_user.notifications.where('id > ?', last_notification_id).order('id DESC').limit(10)
        render json: notifications
      end

      private

      def last_notification_id
        params[:last_id] || 0
      end
    end
  end
end