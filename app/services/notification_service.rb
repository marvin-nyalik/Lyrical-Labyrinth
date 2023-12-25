class NotificationService
  def initialize(recipient, action, notifiable)
    @recipient = recipient
    @action = action
    @notifiable = notifiable
  end

  def create_notification
    Notification.create(
      user_id: @recipient.id,
      action: @action,
      notifiable_id: @notifiable.id,
      notifiable_type: @notifiable.class.name
    )
  end
end
