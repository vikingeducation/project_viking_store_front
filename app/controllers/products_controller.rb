class ProductsController < ApplicationController


  def index
    filter = params[:products_filter]
    @products = filter.present? ? Product.where("category_id = ?", filter) : Product.all
    if params[:item]
      session[:cart] ||= {}
      item = params[:item]
      if Product.where("id = ?", item).present?
        if session[:cart][item]
          session[:cart][item] += 1
        else
          session[:cart][item] = 1
        end
        flash[:success] = "Item added to cart"
      else
        flash[:error] = "Product is invalid"
      end
      redirect_to products_path
    end
  end

  def show
  end


  def edit
    @cart = session[:cart]
    @total = 0
    if @cart
      @cart.each do |product_id, quantity|
        @total += Product.find(product_id).price * quantity
      end
    end
  end

  def update
    @cart = session[:cart]

    params[:order].each do |product_id, quantity|
      session[:cart][product_id] = quantity.to_i
      session[:cart].delete(product_id) if quantity == ("0" || "")
    end

    if params[:remove]

      params[:remove].each do |product_id, _true|
        session[:cart].delete(product_id)
      end

    end

    flash[:success] = "Updated your order quantities."
    render :edit
  end



end
