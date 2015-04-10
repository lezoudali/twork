class UsersController < ApplicationController
  include UsersHelper
  before_action :set_user, only: [:show, :edit, :update, :profile, :jobs]

  def index
    @users = User.all
  end

  def new
  end

  def create
    @user = User.new(user_params)
    set_image if user_params[:image].nil? && File.exists?(@user.twitter_image_location)
    if @user.valid?
      get_new_skills
      log_in if @user.save
      redirect_to jobs_path
    else
      render 'new'
    end
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

  def get_new_skills
    @user.add_new_skills(params[:new_skills].split(/,\s?/))
  end

  def set_image
    @user.image = File.open(@user.twitter_image_location)
  end

  def log_in
    session[:user_id] = @user.id
  end

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).
      permit(:first_name,
        :last_name,
        :email, 
        :bio, 
        :image, 
        :uid, 
        :twitter_handle, 
        skills_ids: []
        )
  end 

end
