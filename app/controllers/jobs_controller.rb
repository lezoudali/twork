class JobsController < ApplicationController
  before_action :set_job, only: [:show, :edit, :update]

  def index
    @jobs = Job.paginate(page: params[:page], per_page: 5).order('created_at DESC')
  end

  def edit 
    redirect_to @job unless @job.contractor == current_user
  end

  def show
    @job = Job.find(params[:id])
  end

  def new
    @current_user = current_user
    @job = Job.new
  end

  def update
    @job.update_attributes(job_params)
    redirect_to request.headers["HTTP_REFERER"]
  end

  def create
    @job = Job.new(job_params)
    @job.contractor = current_user
    if @job.valid?
      get_new_skills
      redirect_to jobs_path if @job.save
    else
      render 'new'
    end
  end

  private 

  def get_new_skills
    @job.add_new_skills(params[:new_skills].split(/,\s?/))
  end

  def set_job
    @job = Job.find(params[:id])
  end 

  def job_params
    params.require(:job).permit(:title, :description, :completed, skill_ids: [] )
  end
end
