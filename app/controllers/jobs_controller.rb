class JobsController < ApplicationController
  def index
  end

  def show
    @job = Job.find(params[:id])
  end

  def new
    @current_user = current_user
    @job = Job.new
    @job.skills.build
  end

  def create
    job = Job.new(job_params)
    job.contractor = current_user
    if job.save
      redirect_to "/jobs"
    end
  end
  private 
  def job_params
    params.require(:job).permit(:title, :description, skill_ids: [] )
  end
end
