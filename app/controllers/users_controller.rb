class UsersController < ApplicationController
  def settings
    
  end

  def save_settings 
    
  end

  private

  def user_settings
    params.permit(:avatar)
  end

end
