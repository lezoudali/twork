class Skill < ActiveRecord::Base
  has_many :user_skills
  has_many :job_skills
  has_many :users, through: :user_skills
  has_many :jobs, through: :job_skills

  def self.sorted 
    self.all.sort_by do |skill|
      skill.jobs.count
    end
  end
end
