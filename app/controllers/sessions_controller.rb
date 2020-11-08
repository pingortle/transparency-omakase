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
    redirect_url = Current.session.authority.then { |authority|
      case authority&.to_sym
      when :auth0 then auth0_url
      when :"cognito-idp" then cognito_url
      else new_session_url
      end
    }

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

  def auth0_url
    URI::HTTPS.build(
      host: ENV["AUTH0_DOMAIN"],
      path: "/v2/logout",
      query: {
        returnTo: root_url,
        client_id: ENV["AUTH0_CLIENT_ID"]
      }.to_query
    ).to_s
  end
end
