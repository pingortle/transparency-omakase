class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by_login(session_params[:login])
    if user&.authenticate(session_params[:password])
      session[:user_id] = user.id
      Current.set_user_with(id: user)
      redirect_to root_url, notice: "Logged in!"
    else
      flash.now[:alert] = "Login or password is invalid"
      render "new"
    end
  end

  def destroy
    Current.reset
    [:oauth_id, :user_id].each do |auth_id|
      session.delete(auth_id)
    end
    redirect_to cognito_url, notice: "Logged out!"
  end

  def session_params
    params.require(:session).permit(:login, :password)
  end

  def cognito_url
    URI.join(
      ENV["COGNITO_USER_POOL_SITE"],
      "logout",
      "?client_id=#{ENV["COGNITO_CLIENT_ID"]}&logout_uri=#{root_url.chomp("/")}"
    ).to_s
  end
end
