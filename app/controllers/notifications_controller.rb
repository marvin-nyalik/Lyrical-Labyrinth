class NotificationsController < ApplicationController
  before_action :authenticate_user!

  def index
    return unless current_user

    @notifications = current_user.notifications.order(created_at: :desc)
  end
end
