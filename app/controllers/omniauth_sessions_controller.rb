class OmniauthSessionsController < ApplicationController
  skip_before_action :verify_authenticity_token, only: :dev_create

  def create
    session[:oauth_id] = auth_hash[:uid]
    Current.user = OpenStruct.new(id: auth_hash[:uid])
    redirect_to "/"
  end

  def dev_create
    raise "Only for development" unless Rails.env.development?
    create
  end

  def auth_hash
    request.env["omniauth.auth"]
  end
end
