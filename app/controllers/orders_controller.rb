class OrdersController < ApplicationController

	def index
	end

	def create

		if current_user.cart.present?
			@order = current_user.cart.first
		else
			@order = Order.new
		end

		session[:cart].each do |k, v|
			@order.build(product_id: k,
									 quantity: v)
		end
		@order.save
		redirect_to 'edit'
	end

	def edit
		@order = current_user.cart.first # let's see what we can pass
	end

	def update
	end

	private

	# def load_cart
	# 	if current_user && current_user.cart.present?
	# 		# Merge the cart and the session cart
	# 		@cart = current_user.cart.first
	# 	elsif current_user
	# 		@cart = Order.new
			# session[:cart].each do |k, v|
			# 	@cart.purchases.build(product_id: k,
			# 												quantity: v)
			# end
			# @cart.save
	# 	else
	# 		@cart = session[:cart]
	# 	end
	# end

end
