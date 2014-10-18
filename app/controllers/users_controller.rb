class UsersController < ApplicationController

  def new
    @user = User.new
    2.times { @user.addresses.build }
  end

  def create
  end

  def update
  end

  def edit

  end

  def destroy
  end
end
