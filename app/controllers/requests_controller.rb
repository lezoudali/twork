class RequestsController < ApplicationController
  def create
    @request = Request.new(job_id: params[:job_id], client_id: current_user.id)
    job = Job.find(params[:job_id])
    redirect_to '/jobs', notice: "Offer Made for '#{job.title}'!"
  end
end
