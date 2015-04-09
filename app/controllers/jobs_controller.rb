class JobsController < ApplicationController
  before_action :set_job, only: [:show, :edit, :update]

  def index
    @jobs = Job.all
  end

  def show
  end

  def edit
    redirect_to @job unless current_user.jobs.include? @job
  end

  def update
    @job.update_attributes(job_params)
    redirect_to request.headers["HTTP_REFERER"]
  end

  def new
    redirect_to root_path unless logged_in?
    @current_user = current_user
    @job = Job.new
  end

  def create
    job = Job.new(job_params)
    job.contractor = current_user
    new_skills = params[:new_skills].split(/,\s?/)
    new_skills.each do |skill_name|
      # binding.pry
      skill = Skill.where("lower(name) = ?", skill_name.downcase)
      if skill.empty?
        job.skills.build(name: skill_name) 
      else
        job.skills << skill.first
      end
    end
    redirect_to "/jobs" if job.save
  end

  private

  def set_job
    @job = Job.find(params[:id])
  end 

  def job_params
    params.require(:job).permit(:title, :description, :completed, skill_ids: [] )
  end
end
