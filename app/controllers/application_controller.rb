class ApplicationController < ActionController::Base
  include HttpAcceptLanguage::AutoLocale

  def current_user
    unless @current_user
      token = request.headers["Authentication-Token"]
      session = Session.find_by(token: token)
      @current_user = session.user if session
    end

    @current_user
  end

  private

  def check_session
    if current_user.nil?
      render text: t(:access_denied), status: :unauthorized
    end
  end
end
