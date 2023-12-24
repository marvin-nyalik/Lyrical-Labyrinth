class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post

  def new
    @comment = Comment.new
  end

  def create
    @comment = @post.comments.build(comment_params)

    if @comment.save
      redirect_to @post, notice: 'Your comment was added'
    else
      flash[:alert] = 'Comment addition failed'
      flash[:error_messages] = @comment.errors.full_messages
      render 'comments/new'
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
