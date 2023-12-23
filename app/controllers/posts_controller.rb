class PostsController < ApplicationController
  before_action :authenticate_user!, except: %i[index show]
  before_action :select_post, only: %i[show destroy edit]

  def new
    @post = Post.new
  end

  def index
    @posts = Post.paginate(page: params[:page], per_page: 9)
  end

  def show; end

  def create
    @post = current_user.posts.build(post_params)

    if @post.save
      flash[:success] = 'Post successfully created'
      redirect_to @post
    else
      flash[:error] = 'Failed to build post'
      render :new
    end
  end

  def edit; end

  def destroy; end

  private


  def post_params
    params.require(:post).permit(:title, :summary, :photo_url, :body, :category_id, tag_ids: [])
  end

  def select_post
    @post = Post.find(params[:id])
  end
end
