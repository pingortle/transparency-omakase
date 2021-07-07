class OmniauthSessionsController < ApplicationController
  skip_before_action :verify_authenticity_token, only: :dev_create

  def create
    identity = Identity.find_or_create_by(
      authority: auth_params[:provider],
      identifier: auth_params[:uid]
    ) { |this|
      this.omniauth_info = auth_params[:info]
    }

    Current.session.authorize(identity)
    redirect_to "/"
  end

  def dev_create
    raise "Only for development" unless Rails.env.development?
    create
  end

  def auth_params
    request.env["omniauth.auth"]
  end
end
