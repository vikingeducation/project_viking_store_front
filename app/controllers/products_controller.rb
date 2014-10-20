class ProductsController < ApplicationController


  def index
    filter = params[:products_filter]
    @products = filter.present? ? Product.where("category_id = ?", filter) : Product.all
  end

  def show
  end


end
