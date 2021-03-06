class RequestsController < ApplicationController
  def create
    @request = Request.new(job_id: params[:job_id], client_id: current_user.id)
    job = Job.find(params[:job_id])

    begin
    if @request.save
      Notification.create(
        user_id: job.contractor.id, 
        sender_id: current_user.id, 
        request_id: @request.id,
        job_id: params[:job_id], 
        kind: "offer"
      )
      flash[:notice] = "Offer Made for '#{job.title}'!"
    end
    rescue
      flash[:info] = "You've already made an offer for '#{job.title}'!"
    end
    
    redirect_to '/jobs'
      # UserMailer.request_made_email(job.contractor).deliver_now
  end

  def update
    @request = Request.find(params[:id])
    @request.accepted = params[:accepted]
    if @request.save
      notification = Notification.new(
        user_id: @request.client.id, sender_id: current_user.id, request_id: @request.id
      )
      notification.kind = params[:accepted] == "true" ? "accepted" : "declined"
      notification.save
    end
    redirect_to controller: 'Notifications', action: 'delete', id: @request.notifications.first.id
  end
end
