class PagesController < ApplicationController
  def home
    return unless current_user

    @notifications = current_user.notifications.where(read: false)
    @notifications.each do |n|
      n.update(read: true)
    end
  end
end
