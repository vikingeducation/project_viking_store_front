class OrderContentsController < ApplicationController
  def index
    @cart = get_user_cart
  end


  private 
  def get_user_cart
    if current_user
      cart = OrderContent.find_by(order_id: Order.where("is_placed=?",false).find_by(user_id: current_user.id))
<<<<<<< HEAD
      if Product.find(cart.product_id)
=======
      if cart
>>>>>>> e5bb121b3d3e482ecd7abc07860bd42174618862
        product_name = Product.find(cart.product_id).title
        product_id = cart.product_id
        session[:cart][product_name] = product_id
        session[:cart]
<<<<<<< HEAD
=======
      else
        session[:cart]
>>>>>>> e5bb121b3d3e482ecd7abc07860bd42174618862
      end
    else
      session[:cart]
    end
      
  end 

end
