class UsersController < ApplicationController
  before_action :authenticate_user!

  def avatar;end

  def appearance;end

  def save_appearance
    current_user.settings(:settings).user_post_color = params[:settings][:user_post_color] unless params[:settings][:user_post_color].nil? 
    if current_user.save!
      flash[:notice] = 'Appearance settings updated Successfully!'
      redirect_to user_settings_path
    else
      render @user_avatar.errors, status: :unprocessable_entity
    end 
  end

  def save_avatar 
    @user_avatar = current_user.avatar.attach(params[:settings][:avatar]) unless params[:settings][:avatar].nil? 
    if current_user.save!
      flash[:notice] = 'Avatar updated Successfully!'
      redirect_to user_settings_path
    else
      flash.now[alert:] = "could not save avatar."
      render @user_avatar.errors, status: :unprocessable_entity
    end
  end

  def activity
    @registered = current_user
    @posts = @registered.posts
    @comments = @registered.comments
    @likes = @registered.likes
    @address = @registered.addresses.first
    @activity = (@posts + @comments + @likes).group_by{|x| x.created_at.strftime("%b %d, %Y")}.sort.reverse

    render 'users/index'
  end

  def premium
    flash[:notice] = "Payment success!" if params[:success] == 1
    @subscription = current_user.subscriptions.last
    @status = current_user.premium?
  end

  private

  def user_settings
    params.permit(:avatar)
  end

end
