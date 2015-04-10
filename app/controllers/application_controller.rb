class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :logged_in?, :current_user
  before_action :check_logged_in

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id].present?
  end
 
  def logged_in?
    !!current_user
  end

  def check_logged_in
    binding.pry
    safe_paths = ["/", "/auth/twitter", "/auth/twitter/callback"]
    unless logged_in? || safe_paths.include?(request.fullpath)
      flash[:alert] = "Please log in"
      redirect_to root_path
    end
  end
end
