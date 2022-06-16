class UsersController < ApplicationController
  before_action :authenticate_user!

  def index;end

  def index
    @registered = User.find_by(username: params[:username])
    @blogs = @registered.blogs
    @comments = @registered.comments
    @likes = @registered.likes
    @activity = (@blogs + @comments + @likes).group_by{|x| x.created_at.strftime("%b %d, %Y")}.sort.reverse
  end

  def save_settings 
    @user_avatar = current_user.avatar.attach(params[:settings][:avatar]) unless params[:settings][:avatar].nil? 
    current_user.settings(:settings).user_blog_color = params[:settings][:user_blog_color] unless params[:settings][:user_blog_color].nil? 
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
