class SkillsController < ApplicationController

  def index
    @skills = Skill.sorted.reverse
  end

  def show
    @skill = Skill.find(params[:id])
  end


end
