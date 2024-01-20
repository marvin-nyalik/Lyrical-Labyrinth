class CleanupNotificationsJob
  include Sidekiq::Job

  def perform(*_args)
    Notification.where('created_at < ?', 1.week.ago).destroy_all
  end
end
