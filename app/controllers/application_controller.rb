class ApplicationController < ActionController::Base
  before_action :set_current_user

  def set_current_user
    Current.user = if session[:user_id]
      User.find_by(id: session[:user_id])
    elsif session[:oauth_id]
      OpenStruct.new(id: session[:oauth_id])
    end
  end
end
