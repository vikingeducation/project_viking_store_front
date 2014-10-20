class OrdersController < ApplicationController
  def index
  end
  def show
    @order = Order.find(params[:id])
  end

  def new
    @order=Order.new
    @user = current_user
    @addresses = @user.addresses
    @payment=@user.payment
    @cartitems = get_cart_items
    @cart_total = get_cart_total

  end

  def create
    @order = current_user.orders.build(order_params)
    @cartitems = get_cart_items
    @user = current_user
    if @order.save
      create_order_content(@order,@cartitems)
      update_order(@order)
      delete_old_order(@user)
      flash[:success] = "Order has been successfully created!"
      redirect_to products_path
    else
      flash[:error] = "Order was not created, please try again"
      render 'new'
    end
  end


  def update
    @user = current_user
    @addresses = @user.addresses
    fail
    
    if @order.create(order_params)
      flash[:success] = "Order Created"
      redirect_to users_path
    else
      flash.now[:error] = "User did not update, please try again"
      render 'new' # something wasn't right, give them another chance
    end

  end

  def clearcart
    session.delete(:cart)
    redirect_to products_path
  end


  private
  def get_cart_items
    products = {}
    session[:cart].each do |product_id,quantity|
      product = Product.find(product_id)
      name = product.title
      price = product.price.to_f

      products[name] = [price,quantity.to_f]

    end
    products
  end

  def get_cart_total
    total=0
    @cartitems.each do |product,pq_array|
      total+=pq_array.reduce(&:*)
    end
    total
  end

  def order_params
    params.require(:order).permit(:shipping_address_id, :billing_address_id)
  end

  def create_order_content(order,cartitems)
    cartitems.each do |product,pq_array|
      o=OrderContent.new
        o.order_id = order.id
        o.product_id = Product.find_by_title(product).id
        o.quantity = pq_array[1].to_i
        o.current_price = pq_array[0].to_f
      o.save
    end
  end

  def update_order(order)
    o=Order.find(order.id)
      o.is_placed = true
      o.placed_at = DateTime.now
    o.save
  end
  def delete_old_order(user)
    if user.orders.where(placed_at: false).any?
        user.orders.where(placed_at: false).all.destroy
    end
    session.delete(:cart)
  end



  
end
