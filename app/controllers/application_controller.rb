class ApplicationController < ActionController::Base
  def current_user
    token = request.headers["Authentication-Token"]
    @current_user ||= Session.find_by(token: token).user if token
  end
end
