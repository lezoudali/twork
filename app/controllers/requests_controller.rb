class RequestsController < ApplicationController
  def create
    @request = Request.new(job_id: params[:job_id], client_id: current_user.id)
    job = Job.find(params[:job_id])
    if @request.save
      Notification.create(
        user_id: job.contractor.id, 
        sender_id: current_user.id, 
        request_id: @request.id,
        job_id: params[:job_id], 
        kind: "offer"
      )
      
      # UserMailer.request_made_email(job.contractor).deliver_now
      redirect_to '/jobs', notice: "Offer Made for '#{job.title}'!"
    end
  end

  def update
    @request = Request.find(params[:id])
    @request.accepted = params[:accepted]
    if @request.save
      notification = Notification.new(
        user_id: @request.client.id, sender_id: current_user.id, request_id: @request.id
      )
      notification.kind = params[:accepted] ? "accepted" : "declined"
      notification.save
    end
    redirect_to request.headers["HTTP_REFERER"]
  end
end
