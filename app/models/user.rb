class User < ActiveRecord::Base
  include Skillable
  
  mount_uploader :image, ImageUploader

  validates_presence_of :first_name, :last_name
  validates_format_of :email, :with => /\A[^@]+@([^@\.]+\.)+[^@\.]+\z/

  has_many :jobs, foreign_key: :contractor_id
  has_many :user_skills
  has_many :skills, through: :user_skills
  has_many :requests, foreign_key: :client_id
  has_many :offers, through: :jobs, source: :requests
  has_many :notifications

  acts_as_messageable

  def self.new_with_omniauth(auth)
    first_name, last_name = auth[:info][:name].strip.split(/\s+/)
    user = User.new(
      first_name: first_name, 
      last_name: last_name,
      provider: auth[:provider], 
      uid: auth[:uid],
      twitter_handle: auth[:info][:nickname],
      bio: auth[:info][:description]
    )
    open(user.twitter_image_location, "wb") do |file|
      file << open(auth[:info][:image].gsub("_normal", "")).read
    end
    user
  end

  def partners
    self.offers.map do |offer|
      offer.client
    end.uniq do |user|
      user.id
    end
  end

  def mailboxer_email(object)
    self.email
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

  def twitter_image_location
    File.join(Rails.root, "/app/assets/images/profile/#{self.uid}.jpg")
  end

  def name
    first_name + " " + last_name
  end
end
