class PagesController < ApplicationController
  def home
    return unless current_user

    @notifications = current_user.notifications.where(read: false)
    @notifications.update_all(read: true)

    respond_to do |format|
      format.html
      format.json { render json: { notifications: @notifications }, status: :ok }
    end
  end
end
