class SessionsController < ApplicationController

  def new
  end

  def create
    user = User.find_by_email(params['session'][:email])
    if user
      sign_in user
      flash[:success] = "Signed in!"
      redirect_to products_path
    else
      flash.now[:error] = "Error. Could not sign in"
      render :new
    end
  end 

  # Sign out our user to destroy a session
  def destroy
    user = current_user
    if sign_out
      flash[:success] = "You have successfully signed out"
      redirect_to products_path
    else
      flash[:error] = "Unable to sign out."
      redirect_to products_path
    end
  end
end
