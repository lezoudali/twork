class NotificationsController < ApplicationController
  def delete
    @notification = Notification.find_by_id(params[:id])
    @notification.delete
    redirect_to request.headers["HTTP_REFERER"]
  end
end