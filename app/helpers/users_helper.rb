module UsersHelper
  def confirmed_logged_in?
    current_user.id == params[:id].to_i
  end
end
