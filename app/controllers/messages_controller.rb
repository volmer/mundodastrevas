class MessagesController < ApplicationController
  def index
    authorize(Message.new)

    if params[:user_id].present?
      user_messages
    else
      all_messages
    end
  end

  def create
    @user = User.find_by_name!(params[:user_id])

    @message = Message.new(message_params)
    @message.sender = current_user
    @message.recipient = @user

    authorize(@message)

    @message.save!

    redirect_to user_messages_path(@user)
  end

  private

  def all_messages
    @messages = Message.distinct_for(current_user).page(params[:page])
  end

  def user_messages
    @user = User.find_by_name!(params[:user_id])
    @messages = Message.all_between(current_user, @user)

    current_user.incoming_messages.where(sender_id: @user.id)
      .update_all(read: true)

    render 'user_index'
  end

  def message_params
    params.require(:message).permit(:content)
  end
end
