class UsersController < ApplicationController
  def new
    @user=User.new
    @states_list = get_states
  end

  def show
    @user = User.find(params[:id])
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "New User \"#{@user.first_name} #{@user.last_name}\" has been successfully created!"
      redirect_to user_path(@user)
    else
      flash[:error] = "User was not created, please try again"
      render 'new'
    end
  end

  private
  def user_params
    params.require(:user).permit(:first_name, :last_name,
         :email, :phone, :default_billing_address_id,
         :default_shipping_address_id, :email_confirmation)
  end


end
