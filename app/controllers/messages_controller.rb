class MessagesController < ApplicationController
  before_action :find_user

  def index
    @message = Message.new
    @room = Room.find(params[:room_id])
    # get all message record along with user info at ONCE
    @messages = @room.messages.includes(:user)
  end

  def create
    @room = Room.find(params[:room_id])
    @message = @room.messages.new(set_message_params)
    if @message.save
      redirect_to room_messages_path(@room)
    else
      redirect_to root_path
    end
  end

  def destroy
  end
  
  private
  def set_message_params
    # only needs to merge user_id: as current_user.id since :room_id's already suggested in URI pattern
    params.require(:message).permit(:content, :image).merge(user_id: current_user.id)
  end
end
