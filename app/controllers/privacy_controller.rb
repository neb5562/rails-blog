class PrivacyController < ApplicationController
  before_action :authenticate_user!

  def index; end

  def save
    
    unless params[:user_email_notify_on_new_ip] == current_user.settings(:privacy).user_email_notify_on_new_ip
      current_user.settings(:privacy).user_email_notify_on_new_ip = !!params[:user_email_notify_on_new_ip] 
    end
    current_user.save!
  end
end
