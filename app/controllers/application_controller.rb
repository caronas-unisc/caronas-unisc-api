class ApplicationController < ActionController::Base
  def current_user
    unless @current_user
      token = request.headers["Authentication-Token"]
      session = Session.find_by(token: token)
      @current_user = session.user if session
    end

    @current_user
  end
end
