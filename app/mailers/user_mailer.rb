class UserMailer < ApplicationMailer
  default from: 'no-reply@noobonrails.org'

  def welcome_email
    @user = params[:user]
    @url  = new_user_session_path
    mail(to: @user.email, subject: 'Welcome to My Awesome Blog')
  end
end
