class User < ActiveRecord::Base

  mount_uploader :image, ImageUploader

  has_many :jobs, foreign_key: :contractor_id
  has_many :user_skills
  has_many :skills, through: :user_skills
  has_many :requests, foreign_key: :client_id
  has_many :offers, through: :jobs, source: :requests
  has_many :conversations, foreign_key: :sender_id

  def self.create_with_omniauth(auth)

    user = User.create(
      name: auth[:info][:name], 
      provider: auth[:provider], 
      uid: auth[:uid],
      twitter_handle: auth[:info][:nickname],
      bio: auth[:info][:description]
    )

    image_location = File.join(Rails.root, "/app/assets/images/profile/#{user.id}.jpg")
    open(image_location, "wb") do |file|
      file << open(auth[:info][:image].gsub("_normal", "")).read
    end
    user.image = File.open(image_location)
    user.save
    user
  end
end
