class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def new
    @user = User.new
    render 'new_user'
  end

  def create
    @user = User.new(whitelisted_user_params)
    if @user.save
      flash[:success] = "User created successfully."
      redirect_to users_path
    else
      flash.now[:error] = "Failed to create User."
      render 'new_user'
    end
  end

  def show
    @user = User.find(params[:id])
    render 'show_user'
  end

  def edit
    @user = User.find(params[:id])
    render 'edit_user'
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(whitelisted_user_params)
      flash[:success] = "User updated successfully."
      redirect_to users_path
    else
      flash.now[:error] = "Failed to update User."
      render 'edit_user'
    end
  end

  def destroy
    @user = User.find(params[:id])
    session[:return_to] ||= request.referer
    if @user.destroy
      flash[:success] = "User deleted successfully."
      redirect_to users_path
    else
      flash[:error] = "Failed to delete User."
      redirect_to session.delete(:return_to)
    end
  end

  private

  def whitelisted_user_params
    params.require(:user).permit(:first_name, :last_name, :email, :billing_id, :shipping_id, :phone_number)
  end
end
