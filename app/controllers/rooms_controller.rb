class RoomsController < ApplicationController
  before_action :find_user
  
  def index
  end

  def new
    @room= Room.new
  end
  
  def create
    @room= Room.new(room_params)
    if @room.save
      redirect_to root_path
    else
      render :new
    end
  end

  private
  def room_params
    # user_ids is in array since it is sent as such.
    params.require(:room).permit(:name, user_ids: [])
  end
end