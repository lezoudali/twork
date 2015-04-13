class Job < ActiveRecord::Base
  include Skillable

  belongs_to :contractor, class_name: "User"

  has_many :requests
  has_many :job_skills
  has_many :skills, through: :job_skills
  accepts_nested_attributes_for :skills

  validates :title, length: {minimum: 10}
  validates :description, length: {maximum: 250}

end
