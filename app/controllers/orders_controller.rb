class OrdersController < ApplicationController

	def index
	end

	def edit
		merge_cart
	end

	private
	def merge_cart
		if current_user && current_user.cart.present?
			# Merge the cart and the session cart
			@cart = current_user.cart.first
		elsif current_user
			@cart = Order.new
			session[:cart].each do |k, v|
				@cart.purchases.build(product_id: k,
															quantity: v)
			end
			@cart.save
		else
			@cart = session[:cart]
		end
	end

end
