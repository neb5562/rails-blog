class FriendsController < ApplicationController
  PER_PAGE = 9
  PER_PAGE_COMMENTS = 15
  def user_friends
    user = User.find_by(username: params[:username])
    friends = user.friends
    render 'friends/user_friends', :locals => { :user => user, :friends => friends }
  end
end
