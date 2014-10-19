class UsersController < ApplicationController
  def new
    @user=User.new
  end

  def update
    @user = current_user
    if @user.update(user_params)
      flash[:success] = "User \"#{@user.first_name} #{@user.last_name}\" has been successfully updated!"
      redirect_to products_path
    else
      flash.now[:error] = "User did not update, please try again"
      render 'edit' # something wasn't right, give them another chance
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = current_user
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "New User \"#{@user.first_name} #{@user.last_name}\" has been successfully created!"
      sign_in(@user)
      redirect_to products_path
    else
      flash[:error] = "User was not created, please try again"
      render 'new'
    end
  end

  private
  def user_params
    params.require(:user)
    .permit(:first_name, :last_name,
         :email, :phone, :default_billing_address_id,
         :default_shipping_address_id, :email_confirmation,
         :addresses_attributes => [
          :state,
          :street_address,
          :city,
          :zip,
          :id,
          :_destroy
         ])
  end

end
