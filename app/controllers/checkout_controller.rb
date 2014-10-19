class CheckoutController < ApplicationController
  def index
    @user = current_user
    @addresses = Address.where(user_id: @user.id)
  end
end
