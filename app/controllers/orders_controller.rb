class OrdersController < ApplicationController

	before_action :verify_user, only: [ :create, :edit ]

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

  def verify_user
    unless signed_in_user?
    	flash[:error] = "Can't check out without signing in!"
      redirect_to new_session_path
    end
  end
end
