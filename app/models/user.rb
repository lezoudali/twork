class User < ActiveRecord::Base
  has_many :jobs, foreign_key: :contractor_id
  has_many :user_skills
  has_many :skills, through: :user_skills
  has_many :requests, foreign_key: :client_id
  def self.create_with_omniauth(hash)
    user_name = hash['info']['name']
    User.create(:name => user_name)
  end
end
