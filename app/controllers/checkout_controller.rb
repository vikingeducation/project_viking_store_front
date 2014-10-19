class CheckoutController < ApplicationController
  def index

    @user = current_user
    @addresses = Address.where(user_id: @user.id)

    if user_has_cart?
      update_cart
    else
      create_cart
    end

  end

  private

  def user_has_cart?
    OrderContent.where(order_id: (@user.orders.find_by(is_placed: false))).exists?
  end

  def update_cart
    cart = OrderContent.where(order_id: (@user.orders.find_by(is_placed: false)))
    
    cart.each do |item|
      session[:cart].each do |product,quant|
        if product.to_i == item.product_id
            item.quantity = quant.to_i
            item.save
        end
      end
    end
  end

  def create_cart
    o=Order.new
      o.user_id = current_user.id
      o.billing_address_id = current_user.default_billing_address_id
      o.shipping_address_id = current_user.default_shipping_address_id
    o.save

    id = o.id

    session[:cart].each do |product,quant|
      o=OrderContent.new
        o.order_id = id
        o.product_id = product
        o.quantity = quant
        o.current_price = Product.find(product).price
      o.save
    end
    
  end
end
