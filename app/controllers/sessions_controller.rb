class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by_login(session_params[:login])
    if user&.authenticate(session_params[:password])
      Current.user = session[:user_id] = user.id
      redirect_to root_url, notice: "Logged in!"
    else
      flash.now[:alert] = "Login or password is invalid"
      render "new"
    end
  end

  def destroy
    Current.user = session[:user_id] = nil
    redirect_to new_session_url, notice: "Logged out!"
  end

  def session_params
    params.require(:session).permit(:login, :password)
  end
end
