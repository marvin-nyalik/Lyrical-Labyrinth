class CategoriesController < ApplicationController
  before_action :authenticate_user!

  def new
    authorize! :create, Category
    @category = Category.new
  end

  def create
    authorize! :create, @category

    @category = Category.new(category_params)

    respond_to do |format|
      if @category.save
        format.html { redirect_to root_path, notice: "Category #{@category.name} added" }
        format.json { render json: { message: "Category #{@category.name} added" }, status: :created }
      else
        format.html { render :new, notice: 'Category addition failed' }
        format.json { render json: { errors: @category.errors }, status: :unprocessable_entity }
      end
    end
  end

  def destroy; end

  private

  def category_params
    params.require(:category).permit(:name, :description)
  end
end
