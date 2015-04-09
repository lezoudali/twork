class JobsController < ApplicationController
  before_action :set_job, only: [:show, :edit, :update]

  def index
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
    job = Job.new(job_params)
    job.contractor = current_user
    new_skills = params[:new_skills].split(/,\s?/)
    new_skills.each do |skill_name|
      skills = Skill.where("lower(name) = ?", skill_name.downcase)
      skill = skills.empty? ? Skill.create(name: skill_name) : skills.first
      # binding.pry
      job.skills << skill 
      # skill.jobs << job 
      # skill.save
    end
    redirect_to jobs_path if job.save
  end

  private 

  def set_job
    @job = Job.find(params[:id])
  end 

  def job_params
    params.require(:job).permit(:title, :description, :completed, skill_ids: [] )
  end
end
