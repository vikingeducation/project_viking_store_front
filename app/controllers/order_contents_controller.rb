class OrderContentsController < ApplicationController
  def index
  @cart = get_user_cart
  end

  def update_cart #this allows a user to modify cart quantities
    params.each do |i|
      i=i[0]
      if i.include?('quantity')
        j = i.gsub(/quantity/,"")
        session[:cart][j]=params[i]
      end
    end
    redirect_to cart_path
  end


  private 
  def get_user_cart
    if current_user && first_access?
      session.delete(:first_access)
      cart = OrderContent.where(order_id: Order.where("is_placed=?",false).find_by(user_id: current_user.id))
      if cart
        cart.each do |cart|
          product_name = Product.find(cart.product_id).title
          product_id = cart.product_id.to_s
          session[:cart][product_id] = cart.quantity
        end
        session[:cart]
      else
        session[:cart]
      end
    else
      session[:cart]
    end
  end 

  def first_access?
    true if session[:first_access]
  end

end

