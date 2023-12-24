class PostsController < ApplicationController
  include PostsHelper
  before_action :authenticate_user!, except: %i[index show]
  before_action :select_post, only: %i[show destroy edit update]

  def new
    @post = Post.new
  end

  def index
    @posts = Post.includes(:comments).order(created_at: :desc).paginate(page: params[:page], per_page: 5)
  end

  def show; end

  def create
    @post = current_user.posts.build(post_params)

    if @post.save
      flash[:success] = 'Post successfully created'
      redirect_to post_path(@post)
    else
      flash[:alert] = 'Failed to build post'
      flash[:error_messages] = @post.errors.full_messages
      render :new
    end
  end

  def edit; end

  def update
    if @post.update(post_params)
      redirect_to @post, notice: 'Post was successfully updated.'
    else
      render :edit, notice: 'Post was not updated!!'
    end
  end

  def destroy; end

  private


  def post_params
    params.require(:post).permit(:title, :summary, :photo_url, :body, :category_id, tag_ids: [])
  end

  def select_post
    @post = Post.friendly.find(params[:slug])
  end
end
