class PurchasesController < ApplicationController
	def create
  end

  def update
    if Purchase.update(update_purchase_params.keys, update_purchase_params.values)
      flash[:success] = "Order contents updated."
      redirect_to orders_path
    else
      flash.now[:error] = "Order contents failed to update."
      render :index # not sure about this one
    end
	end

  def destroy
  end

  private

  def update_purchase_params
    params.require(:purchases)
  end
end
