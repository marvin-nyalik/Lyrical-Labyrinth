module PostsHelper
  def formatted_time(timestamp)
    timestamp&.strftime('%B %e, %Y')
  end
end
