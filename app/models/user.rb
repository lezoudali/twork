class User < ActiveRecord::Base

  mount_uploader :image, ImageUploader

  has_many :jobs, foreign_key: :contractor_id
  has_many :user_skills
  has_many :skills, through: :user_skills
  has_many :requests, foreign_key: :client_id
  has_many :offers, through: :jobs, source: :requests

  def self.create_with_omniauth(hash)
    user_name = hash['info']['name']
    User.create(:name => user_name, provider: hash[:provider], uid: hash[:uid])
  end
end
