class TagsController < ApplicationController
  before_action :authenticate_user!
  def new
    @tag = Tag.new
  end

  def create
    @tag = Tag.new(tag_params)

    if @tag.save
      redirect_to root_path, notice: "Tag - #{@tag.name} successfully created"
    else
      render :new, notice: "Unauthorized action for #{current_user.full_name}"
    end
  end

  def destroy; end

  private

  def tag_params
    params.require(:tag).permit(:name, :desc)
  end
end
