class SkillsController < ApplicationController
  def index
    @skills = Skill.sorted.reverse
  end
end
