class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :profile]

  def index
    @users = User.all
  end

  def show
    render 'profile' if current_user.id == params[:id].to_i
  end

  def edit
  end

  def update
    skill_names = params[:skill].split(/,\s?/)
    @user.update_attributes(user_params)
    skill_names.each do |name|
      @user.skills.create(name: name)
    end

    redirect_to user_path(@user)
  end


  private
  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :email, :bio, :image)
  end 

end
