class CategoriesController < ApplicationController
  def index
    @categories = Category.all
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(whitelisted_category_params)
    if @category.save
      flash[:success] = "Category created successfully."
      redirect_to category_path(@category.id)
    else
      flash.now[:error] = "Failed to create Category."
      render new_category_path
    end
  end

  def show
    @category = Category.find(params[:id])
  end

  def edit
    @category = Category.find(params[:id])
  end

  def update
  end

  def destroy
  end

  private

  def whitelisted_category_params
    params.require(:category).permit(:name)
  end
end
