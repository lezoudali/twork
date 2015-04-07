class JobsController < ApplicationController
  def new
    @current_user = current_user
    @job = Job.new
    @job.skills.build
  end

  def create
    # binding.pry
  end
end
