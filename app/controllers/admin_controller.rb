class AdminController < ApplicationController
  layout "admin_interface"
  def index
    #
    session.delete(:cart)
  end
end
