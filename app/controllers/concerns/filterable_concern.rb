module FilterableConcern
  extend ActiveSupport::Concern

  # included do
  #   before_action :set_filtered_posts, only:[:poetry, :shorts, :folklore, :fairytale]
  # end

  private

  def set_filtered_posts
    category_mapping = {
      poems: 1,
      reflections: 2,
      scars: 3
    }

    category_id = category_mapping[action_name.to_sym]
    @posts = Post.includes(:comments).where(category: category_id).order(created_at: :desc).paginate(
      page: params[:page], per_page: 5
    )
    render 'index'
  end
end
