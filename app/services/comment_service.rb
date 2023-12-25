require_relative 'notification_service'

class CommentService
  def initialize(post, user, comment_params)
    @post = post
    @user = user
    @comment_params = comment_params
  end

  def create_comment_with_notifications
    comment = @post.comments.build(@comment_params)
    comment.user = @user

    if comment.save
      notify_post_author(@post.user, @user, comment)
      true
    else
      false
    end
  end

  private

  def notify_post_author(recipient, user, comment)
    Notification.create(
      user: recipient,
      action: "#{user.full_name} commented on your post",
      notifiable_id: comment.id,
      notifiable_type: comment.class.name
    )
  end
end
