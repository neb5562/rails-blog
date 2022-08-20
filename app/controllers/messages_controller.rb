class MessagesController < ApplicationController

  def create
    @user = User.find(params[:username])
    @message = @user.messages.build(message_params)
    @message.save
  
    # You can then broadcast to the room like follows
    # DmChannel.broadcast_to(@user, @message)
  end

  def index
    # get last seen message user
    # redirect to this conversation
  end

  def user
    render 'messages/index'
  end

  private

  def message_params
    params.permit(:body, :send_id, :receive_id)
  end
end
