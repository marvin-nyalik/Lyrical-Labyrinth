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

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    redirect_to @post, notice: 'Comment successfully deleted'
  end


  private

  def comment_params
    params.permit(:body)
  end

  def set_post
    @post = Post.friendly.find(params[:post_slug])
  end
end
