class UsersController < ApplicationController
  before_action :authenticate_user!

  def settings
    
  end

  def save_settings 
    @user_avatar = current_user.avatar.attach(params[:avatar])
    if @user_avatar
      flash[:notice] = 'Avatar Uploaded Successfully!'
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
