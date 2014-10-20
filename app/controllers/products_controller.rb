class ProductsController < ApplicationController
  def index

    @products = params[:category_id].blank? ? Product.paginate(page: params[:page], :per_page => 12) : Product.where("category_id = ?", params[:category_id]).paginate(page: params[:page],:per_page => 100)
    @categories = Category.all.map { |i| [i.name, i.id]}
    
    make_visitor_session
    if params[:product]
      product = params[:product]
      if Product.where("id = ?", product).present?
        if session[:cart][product]
          session[:cart][product] = session[:cart][product].to_i + 1
        else
          session[:cart][product] = 1
        end
        flash[:success] = "#{Product.find(product).title} added to cart."
      else
        flash[:error] = "Product is invalid"
      end
      redirect_to products_path
    end
  end


  private 

  def make_visitor_session
    session[:cart] ||= {}
  end



end
