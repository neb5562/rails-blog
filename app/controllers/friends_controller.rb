class FriendsController < ApplicationController
  def user_friends
    user = User.find_by(username: params[:username])
    render 'friends/user_friends', :locals => { :user => user }
  end
end
