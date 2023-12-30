class PagesController < ApplicationController
  def home
    return unless current_user

    @notifications = current_user.notifications.where(read: false)
    @notifications.each do |n|
      n.update(read: true)
    end

    respond_to do |format|
      format.html
      format.json { render json: { notifications: @notifications }, status: :ok }
    end
  end
end
