class ApplicationController < ActionController::Base
  before_action :links
  helper_method :links

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_path, alert: exception.message
  end

  def links
    @categories = Category.all
  end
end
