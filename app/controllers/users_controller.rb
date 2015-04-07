class UsersController < ApplicationController
  def show

  end

  def create
    if @current_user = User.find_by_provider_and_uid(auth_hash[:provider], auth_hash[:uid])
      session['user_id'] = @current_user.id
      redirect_to '/home'
    else
      @current_user = User.create_with_omniauth(auth_hash)
      session['user_id'] = @current_user.id
      redirect_to '/profile'
    end
  end


  def edit
  end

  private
  def auth_hash
    request.env['omniauth.auth']
  end
end
