class CategoriesController < ApplicationController
  before_action :authenticate_user!

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)

    if @category.save
      redirect_to root_path, notice: "Category #{@category.name} added"
    else
      render :new, notice: 'Category addition failed'
    end
  end

  def destroy; end

  private

  def category_params
    params.require(:category).permit(:name, :description)
  end
end
