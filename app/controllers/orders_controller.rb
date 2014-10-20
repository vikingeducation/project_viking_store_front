class OrdersController < ApplicationController

	before_action :verify_user, only: [ :create, :edit ]
  before_action :verify_cart, only: [ :create ]

	def index
	end

	def create

		if current_user.cart.present?
			@order = current_user.cart.first
			@order.purchases.destroy_all
		else
			@order = current_user.orders.build(checked_out: false)
		end

		session[:cart].each do |k, v|
			@order.purchases.build(product_id: k,
									 					 quantity: v)
		end

    if current_user.credit_card
      @order.credit_card = current_user.credit_card
    end

		@order.save!
		redirect_to edit_order_path(@order)
	end

	def edit
		@order = current_user.cart.first # let's see what we can pass
		@order.build_credit_card(user_id: @order.user.id) unless @order.credit_card

    @total = 0
    @order.purchases.each do |purchase|
      @total += (purchase.product.price * purchase.quantity)
    end
	end

	def update
		@order = Order.find(params[:id])
    @order.build_credit_card(whitelisted_credit_card)

		if @order.credit_card.save && @order.update(checkout_params) && (@order.billing && @order.shipping && @order.credit_card)
			flash[:success] = "You just bought some axes!"
			@order.checked_out = true
			@order.checkout_date = Time.now
			@order.save
			session.delete(:cart)
			redirect_to root_path
		else
			flash[:error] = "There is something wrong with your order."
			render :edit
		end
	end

	private

  def verify_cart
  	session[:cart] ||= {}
    if session[:cart].empty?
      flash[:error] = "Empty cart! Do more shopping first."
      redirect_to root_path
    end
  end

  def verify_user
    unless signed_in_user?
    	flash[:error] = "Can't check out without signing in!"
      redirect_to new_session_path
    end
  end

  def checkout_params
  	params.require(:order).permit(:id,
  																:shipping_id,
  																:billing_id,
  																)
  end

  def whitelisted_credit_card
    params[:credit_card][:user_id] = current_user.id
    params.require(:credit_card).permit(:id, :card_number, :exp_month, :exp_year, :ccv, :user_id)
  end

end
