class User < ActiveRecord::Base

  mount_uploader :image, ImageUploader

  has_many :jobs, foreign_key: :contractor_id
  has_many :user_skills
  has_many :skills, through: :user_skills
  has_many :requests, foreign_key: :client_id
  has_many :offers, through: :jobs, source: :requests

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

  def unread_offers
    offers.where(accepted: nil).select{|offer| !offer.job.completed }
  end

  def accepted_offers
    offers.where(accepted: true).select{|offer| !offer.job.completed}
  end

  def declined_offers
    offers.where(accepted: false)
  end

  def completed_offers
    offers.select do |offer|
      offer.job.completed 
    end.uniq {|offer| offer.job.title}
  end

  def uncompleted_jobs
    jobs.where(completed: false)
  end

end
