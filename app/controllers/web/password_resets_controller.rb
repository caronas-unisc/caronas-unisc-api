module Web
  class PasswordResetsController < ApplicationController
    before_action :set_user, only: [:reset_form, :reset_password]

    def reset_form
    end

    def reset_password
      @user.password_reset_sent_at = nil
      @user.password = @user.password_confirmation = ''
      @user.validate_password_confirmation = true
      @user.validate_password = true
      @user.assign_attributes(user_params)
      
      if @user.save
        render :success
      else
        render :reset_form
      end
    end

    private

    def set_user
      @user = User.find_by_active_password_reset_token(params[:token])
      show_expired_message unless @user
    end

    def show_expired_message
      render :expired
    end

    def user_params
      params.require(:user).permit(:password, :password_confirmation)
    end
  end
end