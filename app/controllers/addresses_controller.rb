class AddressesController < ApplicationController
  
  def index
    @addresses = Address.all
    render 'addresses_index'
  end

  def new
    @address = Address.new
  end

  def create
    @address = Address.new(whitelisted_address_params)
    if @address.save
      flash[:success] = "Address created successfully."
      redirect_to addresses_path
    else
      flash.now[:error] = "Failed to create Address."
      render new_addresses_path
    end
  end

  def show
    @address = Address.find(params[:id])
  end

  def edit
    @address = Address.find(params[:id])
  end

  def update
    @address = Address.find(params[:id])
    if @address.update_attributes(whitelisted_address_params)
      flash[:success] = "Address updated successfully."
      redirect_to addresses_path
    else
      flash.now[:error] = "Failed to update Address."
      render edit_address_path
    end
  end

  def destroy
    @address = Address.find(params[:id])
    session[:return_to] ||= request.referer
    if @address.destroy
      flash[:success] = "Address deleted successfully."
      redirect_to addresses_path
    else
      flash[:error] = "Failed to delete Address."
      redirect_to session.delete(:return_to)
    end
  end

  private

  def whitelisted_address_params
    params.require(:address).permit(:name, :sku, :price, :category_id)
  end

end
