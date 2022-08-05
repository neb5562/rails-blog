class RequestsController < ApplicationController

  def create 
    @request = Request.new(request_params)
    @request.user = current_user
    @request.to_user = User.find(params[:to_user_id])
    if @request.save
      redirect_to user_public_profile_path(@request.to_user.username), notice: "Friend request was successfully sent."
    else
      flash.now[alert:] = "Could not sent request."
      render 'users/profile', status: :unprocessable_entity
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
