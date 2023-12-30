class CommentsController < ApplicationController
  require_relative '../services/comment_service'

  before_action :authenticate_user!
  before_action :set_post
  before_action :set_comment, only: %i[edit update edit_reply update_reply]

  def new
    @comment = Comment.new
  end

  def create
    comment_service = CommentService.new(@post, current_user, comment_params)
    result = comment_service.create_comment_with_notifications

    respond_to do |format|
      if result[:success]
        format.html { redirect_to @post, notice: 'Your comment was added' }
        format.json { render json: { comment: result[:comment], message: 'Your comment was added' }, status: :created }
      else
        format.html { redirect_to @post, alert: 'Comment not created' }
        format.json { render json: { errors: result[:errors] }, status: :unprocessable_entity }
      end
    end
  end

  def show
    @p_comment = Comment.includes(:replies).find(params[:id])
    @reply = Comment.new(parent: @p_comment)

    respond_to do |format|
      format.html
      format.json { render json: { comment: @p_comment }, status: :ok }
    end
  end

  def edit; end

  def edit_reply
    @p_comment = @comment.parent
  end

  def update
    authorize! :update, @comment

    respond_to do |format|
      if @comment.update(comment_update_params)
        format.html { redirect_to post_path(slug: @comment.post.slug), notice: 'Comment edited' }
        format.json { render json: { comment: @comment, message: 'You edited your comment' }, status: :ok }
      else
        format.html { redirect_to post_path(slug: @comment.post.slug), notice: 'Comment edit failed' }
        format.json { render json: { errors: @comment.errors.full_messages }, status: :unprocessable_entity }
      end
    end
  end

  def update_reply
    authorize! :update, @comment

    respond_to do |format|
      if @comment.update(comment_update_params)
        format.html do
          redirect_to post_comment_path(post_slug: params[:post_slug], id: @comment.parent.id), notice: 'Reply edited'
        end
        format.json { render json: { reply: @comment, message: 'You edited your reply' }, status: :ok }
      else
        format.html do
          redirect_to post_comment_path(post_slug: params[:post_slug], id: @comment.parent.id),
                      notice: 'Reply edit failed'
        end
        format.json { render json: { errors: @comment.errors.full_messages }, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    authorize! :destroy, @comment

    @comment.destroy
    redirect_to @post, notice: 'Comment successfully deleted'
  end

  def reply_to_comment
    @parent_com = Comment.find(params[:id])
    @reply = Comment.new(parent: @parent_com)

    comment_params = params.require(:comment).permit(:body)
    comment_service = CommentService.new(@parent_com, current_user, comment_params)
    result = comment_service.create_comment_reply_notifications

    respond_to do |format|
      if result[:success]
        format.html do
          redirect_to post_comment_path(post_slug: params[:post_slug], id: @parent_com.id),
                      notice: 'Your reply was added'
        end
        format.json { render json: { message: 'Your reply was added', reply: result[:reply] }, status: :created }
      else
        format.html do
          redirect_to post_comment_path(post_slug: @parent_com.post.slug, id: @parent_com.id),
                      alert: 'Reply not created'
        end
        format.json { render json: { errors: result[:errors] }, status: :unprocessable_entity }
      end
    end
  end

  private

  def comment_params
    params.permit(:body)
  end

  def comment_update_params
    params.require(:comment).permit(:body)
  end

  def set_post
    @post = Post.friendly.find(params[:post_slug])
  end

  def set_comment
    @comment = Comment.find(params[:id])
  end
end
