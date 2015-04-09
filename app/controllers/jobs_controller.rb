class JobsController < ApplicationController
  def index
  end

  def show
    @job = Job.find(params[:id])
  end

  def new
    @current_user = current_user
    @job = Job.new
  end

  def create
    job = Job.new(job_params)
    job.contractor = current_user
    new_skills = params[:new_skills].split(/,\s?/)
    new_skills.each do |skill_name|
      binding.pry
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

  def job_params
    params.require(:job).permit(:title, :description, skill_ids: [] )
  end
end
