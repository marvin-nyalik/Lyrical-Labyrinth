class PostsController < ApplicationController
  include PostsHelper
  include FilterableConcern
  before_action :authenticate_user!, except: %i[index show tagged categorized]
  before_action :select_post, only: %i[show destroy edit update]

  def new
    authorize! :create, Post
    @post = Post.new
  end

  def index
    @posts = Post.includes(:comments).order(created_at: :desc).paginate(page: params[:page], per_page: 5)

    respond_to do |format|
      format.html
      format.json do
        render json: {
          posts: @posts,
          meta: {
            total_pages: @posts.total_pages,
            current_page: @posts.current_page,
            total_items: @posts.total_entries
          }
        }, status: :ok
      end
    end
  end

  def show; end

  def create
    authorize! :create, Post
    @post = current_user.posts.build(post_params)

    respond_to do |format|
      if @post.save
        format.html do
          flash[:success] = 'Post successfully created'
          redirect_to post_path(@post)
        end
        format.json { render json: { post: @post, message: 'Post successfully created' }, status: :created }
        UserMailer.article_create_mail(@post.user).deliver_now
      else
        format.html do
          flash[:alert] = 'Failed to build post'
          flash[:error_messages] = @post.errors.full_messages
          render :new
        end
        format.json { render json: { errors: @post.errors.full_messages }, status: :unprocessable_entity }
      end
    end
  end

  def edit; end

  def update
    authorize! :update, @post

    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to @post, notice: 'Post was successfully updated.' }
        format.json { render json: { post: @post, message: 'Post was successfully updated.' }, status: :ok }
      else
        format.html { render :edit, notice: 'Post was not updated!!' }
        format.json { render json: { errors: @post.errors.full_messages }, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    authorize! :destroy, @post
  end

  def tagged
    @tag = Tag.find_by(name: params[:tag_name])
    @posts = @tag.posts.includes(:comments).order(created_at: :desc).paginate(page: params[:page], per_page: 5)
    render 'index'
  end

  def categorized
    @category = Category.find_by(name: params[:category_name])
    @posts = @category.posts.includes(:comments).order(created_at: :desc).paginate(page: params[:page], per_page: 5)
    render 'index'
  end

  private

  def post_params
    params.require(:post).permit(:title, :summary, :photo_url, :body, :category_id, tag_ids: [])
  end

  def select_post
    @post = Post.friendly.find(params[:slug])
  end
end
