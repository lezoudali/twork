class SessionsController < ApplicationController

  def create
    if user = User.find_by_provider_and_uid(auth["provider"], auth["uid"])
      session[:user_id] = user.id
      redirect_to root_path, :notice => "Signed in!"
    else
      @user = User.new_with_omniauth(auth)
      render '/users/new'
    end
  end

  def destroy
    reset_session
    redirect_to root_path, :notice => "Signed out!"
  end

  protected
  def auth
    request.env["omniauth.auth"]
  end

end