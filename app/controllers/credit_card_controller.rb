class CreditCardController < ApplicationController

  def destroy
  	@credit_card = CreditCard.find(params[:id])
    render 'show_user'
  end
end
