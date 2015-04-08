class UserMailer < ApplicationMailer
 default from: "flatirontwork@gmail.com"
 
  def request_made_email(user)
    @user = user
    @url  = 'http://twork.com/users/#{user.id}'
    mail(to: @user.email, subject: 'testing')
  end
end

#{@current_user.name.upcase} has made an offer on your job.