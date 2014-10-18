class OrderContentsController < ApplicationController
  def index
    @cart = session[:cart]
  end
end
