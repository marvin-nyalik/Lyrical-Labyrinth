class TagsController < ApplicationController
  before_action :authenticate_user!
  def new
    authorize! :create, Tag
    @tag = Tag.new
  end

  def create
    authorize! :create, @tag

    @tag = Tag.new(tag_params)

    respond_to do |format|
      if @tag.save
        format.html { redirect_to root_path, notice: "Tag - #{@tag.name} successfully created" }
        format.json { render json: { message: "Tag - #{@tag.name} successfully created" }, status: :created }
      else
        format.html { render :new, alert: 'You are not authorized to create a tag. Please contact admin.' }
        format.json { render json: { errors: @tag.errors.full_messages }, status: :unprocessable_entity }
      end
    end
  end

  def destroy; end

  private

  def tag_params
    params.require(:tag).permit(:name, :desc)
  end
end
