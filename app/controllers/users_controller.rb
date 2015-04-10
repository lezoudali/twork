class UsersController < ApplicationController
  include UsersHelper
  before_action :set_user, only: [:show, :edit, :update, :profile, :jobs]

  def index
    @users = User.all
  end

  def new
  end

  def create
    @user = User.create(user_params)
    log_in @user
  end

  def jobs
    @jobs = @user.jobs
  end

  def show
    render 'profile' if confirmed_logged_in?
  end

  def edit
    redirect_to root_path unless confirmed_logged_in?
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
