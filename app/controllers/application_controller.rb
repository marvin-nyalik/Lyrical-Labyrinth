class ApplicationController < ActionController::Base
  before_action :links
  helper_method :links
  before_action :track_user_request

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_path, alert: exception.message
  end

  def track_user_request
    user_ip = request.remote_ip
    ::Yabeda.user_requests.increment({ ip: user_ip })
  end

  def links
    @categories = Category.all
  end
end
