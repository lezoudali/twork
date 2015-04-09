class RequestsController < ApplicationController
  def create
    @request = Request.new(job_id: params[:job_id], client_id: current_user.id)
    job = Job.find(params[:job_id])
      if @request.save
        UserMailer.request_made_email(job.contractor).deliver_now
      end
    redirect_to '/jobs', notice: "Offer Made for '#{job.title}'!"
  end

  def update
    r = Request.find(params[:id])
    r.accepted = params[:accepted]
    r.save
    redirect_to request.headers["HTTP_REFERER"]
  end
end
