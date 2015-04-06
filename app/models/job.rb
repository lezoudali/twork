class Job < ActiveRecord::Base
  belongs_to :contractor, class_name: "User"
  has_many :requests
  has_many :job_skills
  has_many :skills, through: :job_skills
end
