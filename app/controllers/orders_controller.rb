class OrdersController < ApplicationController

	before_action :verify_user, only: [ :create, :edit ]

	def index
	end

	def create

		if current_user.cart.present?
			@order = current_user.cart.first
			@order.purchases.destroy
		else
			@order = current_user.orders.build(checked_out: false)
		end

		session[:cart].each do |k, v|
			@order.purchases.build(product_id: k,
									 quantity: v)
		end
		@order.save!
		redirect_to edit_order_path(@order)
	end

	def edit
		@order = current_user.cart.first # let's see what we can pass
	end

	def update
	end

	private

  def verify_user
    unless signed_in_user?
    	flash[:error] = "Can't check out without signing in!"
      redirect_to new_session_path
    end
  end
end
