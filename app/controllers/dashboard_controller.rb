class DashboardController < ApplicationController
  def index
    @all_time = nil
    setup_overall_platform([30, 7, @all_time])
    @top_states = User.top_three_states
    @top_cities = User.top_three_cities

    @top_order = User.top_order
    @highest_lifetime = User.highest_lifetime
    @highest_average = User.highest_average_order
    @most_orders = User.most_orders

    @order_days = []
    @daily_revenue = []
    (0..6).each do |x|
      @order_days << Order.orders_on(x)
      @daily_revenue << Order.daily_revenue(x)
    end
  end





private

def setup_overall_platform(time_frames)
  @new_users = {}
  @new_orders = {}
  @new_products = {}
  @revenue = {}
  @largest_order = {}

  time_frames.each do |day|
    @new_users[day] = User.new_users(day)
    @new_orders[day] = Order.new_orders(day)
    @new_products[day] = Product.new_products(day)
    @revenue[day] = Purchase.revenue(day)
    @largest_order[day] = Order.largest_value(day)
  end
end


end
