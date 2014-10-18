class UsersController < ApplicationController

  def new
    @user = User.new
    2.times { @user.addresses.build }
  end

  def create
    @user = User.new(whitelisted_params)
    if @user.save
      set_defaults
      flash[:success] = "Wanna buy an axe?"
      sign_in(@user)
      redirect_to products_path
    else
      flash[:error] = "Signup failed because REASONS."
      render :new
    end
  end

  def update
  end

  def edit

  end

  def destroy
  end

  private

  def whitelisted_params
    check_cities
    params.require(:user).permit(:email, :first_name, :last_name, :phone_number, {:addresses_attributes => [:id, :user_id, :street_address, :city_id, :state_id, :zip_code, :_destroy]})
  end

  def check_cities
    addresses = params[:user][:addresses_attributes]
    address_keys = addresses.keys

    address_keys.each do |key|
      next if addresses[key][:city_id] == ""
      addresses[key][:city_id] = check_city(key, addresses[key][:city_id])
    end

  end

  def check_city(key, city)

    if City.find_by(name: city)
      City.find_by(name: city).id
    else
      c = City.create(name: city)
      c.id
    end

  end

  def set_defaults
    addresses = params[:user][:addresses_attributes]
    billing = params[:user][:billing_id]
    shipping = params[:user][:shipping_id]

    if billing
      @user.billing = @user.addresses.find_by(street_address: addresses[billing][:street_address])
    end
    if shipping
      @user.shipping = @user.addresses.find_by(street_address: addresses[shipping][:street_address])
    end
    @user.save
  end

end
