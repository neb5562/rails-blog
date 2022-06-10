class UsersController < ApplicationController
  before_action :authenticate_user!

  def settings
    
  end

  def save_settings 
    @user_avatar = current_user.avatar.attach(params[:avatar])
    current_user.settings(:settings).user_blog_color = params[:user_blog_color]
    if current_user.save!
      flash[:notice] = 'Settings updated Successfully!'
      redirect_to user_settings_path
    else
      render @user_avatar.errors, status: :unprocessable_entity
    end 
  end

  private

  def user_settings
    params.permit(:avatar)
  end

end
