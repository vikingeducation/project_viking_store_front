class DashboardController < ApplicationController
  def index
    @all_time = nil
    setup_overall_platform([30, 7, @all_time])
    @top_states = User.top_three_states
    @top_cities = User.top_three_cities
  end





private

def setup_overall_platform(time_frames)
  @new_users = {}
  @new_orders = {}
  @new_products = {}
  @revenue = {}

  time_frames.each do |day|
    @new_users[day] = User.new_users(day)
    @new_orders[day] = Order.new_orders(day)
    @new_products[day] = Product.new_products(day)
    @revenue[day] = Purchase.revenue(day)
  end
end


end
