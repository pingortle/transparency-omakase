class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(login: session_params[:login])
    if user&.authenticate(session_params[:password])
      Current.session.authorize(user)
      redirect_to root_url, notice: "Logged in!"
    else
      flash.now[:alert] = "Login or password is invalid"
      render "new"
    end
  end

  def destroy
    redirect_url = Current.session.authorization&.authority.then { |authority|
      authority.to_s == "cognito-idp" ? cognito_url : new_session_url
    } || new_session_url
    Current.session.revoke
    redirect_to redirect_url, notice: "Logged out!"
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
