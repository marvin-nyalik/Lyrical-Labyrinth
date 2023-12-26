class CommentsController < ApplicationController
  require_relative '../services/comment_service'

  before_action :authenticate_user!
  before_action :set_post

  def new
    @comment = Comment.new
  end

  def create
    comment_service = CommentService.new(@post, current_user, comment_params)

    if comment_service.create_comment_with_notifications
      redirect_to @post, notice: 'Your comment was added'
    else
      redirect_to @post, alert: 'Comment not created'
    end
  end

  def show
    @p_comment = Comment.includes(:replies).find(params[:id])
    @reply = Comment.new(parent: @p_comment)
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    redirect_to @post, notice: 'Comment successfully deleted'
  end

  def reply_to_comment
    @parent_com = Comment.find(params[:id])
    @reply = Comment.new(parent: @parent_com)

    comment_params = params.require(:comment).permit(:body)
    comment_service = CommentService.new(@parent_com, current_user, comment_params)
    det = comment_service.create_comment_reply_notifications

    if det
      redirect_to post_comment_path(post_slug: @parent_com.post.slug, id: @parent_com.id),
                  notice: 'Your reply was added'
    else
      redirect_to post_comment_path(post_slug: @parent_com.post.slug, id: @parent_com.id), alert: 'Reply not created'
    end
  end

  private

  def comment_params
    params.permit(:body)
  end

  def set_post
    @post = Post.friendly.find(params[:post_slug])
  end
end
