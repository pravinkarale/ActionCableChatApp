class ChatRoomsController < ApplicationController
  def index
    @chat_rooms = ChatRoom.all
  end

  def show
		@chat_room = ChatRoom.includes(:messages).find_by(id: params[:id])
		@message = Message.new
	end

  def new
    @chat_room = ChatRoom.new
  end

  def create
    @chat_room = current_user.chat_rooms.build(chat_room_params)
    if @chat_room.save
      flash[:success] = 'Chat room added!'
      redirect_to chat_rooms_path
    else
      render 'new'
    end
  end

  def create_message
    params[:message].merge!(chat_room_id: params[:id])
    @message = current_user.messages.build(message_params)
    if @message.save
      redirect_to chat_room_path(params[:id])
    else
      flash[:alert] = 'Unable to broadcast message'
      redirect_to chat_room_path(params[:id])
    end
  end

  private

  def chat_room_params
    params.require(:chat_room).permit(:title, :message)
  end

  def message_params
    params.require(:message).permit(:chat_room_id, :body)
  end
end
