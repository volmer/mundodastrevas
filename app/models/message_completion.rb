class MessageCompletion
  def initialize(message)
    @message = message
  end

  def create
    successful = @message.save

    notify_recipient if successful

    successful
  end

  private

  def notify_recipient
    notification            = Notification.new
    notification.user       = @message.recipient
    notification.event      = 'new_message'
    notification.notifiable = @message
    notification.send!
  end
end
