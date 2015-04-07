class JobsController < ApplicationController
  def index

  end

  def new
    @current_user = current_user
    @job = Job.new
    @job.skills.build
  end

  def create
    binding.pry
    job = Job.new(job_params)
    if job.save
      redirect_to "/jobs"
    end
  end
  private 
  def job_params
    params.require(:job).permit(:title, :description, skill_ids: [] )
  end
end
