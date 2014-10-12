class OrdersController < ApplicationController
  def index
    @orders = Order.all
  end

  def new
    @order = Order.new
  end

  def create
    @order = Order.new(whitelisted_order_params)
    if @order.save
      flash[:success] = "Order created successfully."
      redirect_to orders_path
    else
      flash.now[:error] = "Failed to create Order."
      render new_order_path
    end
  end

  def show
    @order = Order.find(params[:id])
  end

  def edit
    @order = Order.find(params[:id])
  end

  def update
    @order = Order.find(params[:id])
    if @order.update_attributes(whitelisted_order_params)
      flash[:success] = "Order updated successfully."
      redirect_to orders_path
    else
      flash.now[:error] = "Failed to update Order."
      render edit_order_path
    end
  end

  def destroy
    @order = Order.find(params[:id])
    session[:return_to] ||= request.referer
    if @order.destroy
      flash[:success] = "Order deleted successfully."
      redirect_to orders_path
    else
      flash[:error] = "Failed to delete Order."
      redirect_to session.delete(:return_to)
    end
  end

  private

  def whitelisted_order_params
    params.require(:order).permit(:user_id, :billing_id, :shipping_id, :checked_out, :checkout_date)
  end
end
