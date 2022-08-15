class RequestsController < ApplicationController

  def create 
    @request = Request.new(request_params)
    @request.user = current_user
    if @request.save
      redirect_to user_public_profile_path(User.find(params[:to_user_id]).username), notice: "Friend request was successfully sent."
    else
      flash.now[alert:] = "Could not sent request."
      render 'users/profile', status: :unprocessable_entity
    end
  end

  def accept 
    ActiveRecord::Base.transaction do
      request = Request.where(to_user_id: current_user.id, user_id: params[:first_id]).first
      from_user = User.find(request.user_id)
      friends = Friend.new(first_id: request.to_user_id, second_id: request.user_id)
      friends.save!
      request.destroy!
      redirect_to user_public_profile_path(from_user.username), notice: "you and #{from_user.full_name} are now friends!"
    rescue
      redirect_to user_public_profile_path(from_user.username), alert: "something went wrong!"
    end
  end

  def destroy
    @request = Request.find_by(to_user_id: params[:to_user_id], user_id: current_user.id)
    @request.destroy
    @user = User.find(params[:to_user_id])
    redirect_to user_public_profile_path(@user.username), notice: "Friend request was successfully deleted."
  end

  private

  def request_params
    params.permit(:to_user_id)
  end
end
