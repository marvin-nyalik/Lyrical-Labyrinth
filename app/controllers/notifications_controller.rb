class NotificationsController < ApplicationController
  before_action :authenticate_user!

  def index
    return unless current_user

    CleanupNotificationsJob.perform_async

    @notifications = current_user.notifications.order(created_at: :desc)
    respond_to do |format|
      format.html
      format.json { render json: { notifications: @notifications }, status: :ok }
    end
  end
end
