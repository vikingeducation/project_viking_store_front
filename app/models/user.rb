class User < ActiveRecord::Base

  def self.new_users(last_x_days = nil)
    if last_x_days
      User.where("created_at > ?", Time.now - last_x_days.days).size
    else
      User.all.size
    end
  end

  def self.top_three_states
    User.select("states.name AS state_name, COUNT(*) AS users_in_state").joins("JOIN addresses ON users.billing_id = addresses.id JOIN states ON states.id = addresses.state").limit(3).order("users_in_state DESC").group("states.name")
  end

  def self.top_three_cities
    User.select("cities.name AS city_name, COUNT(*) AS users_in_city").joins("JOIN addresses ON users.billing_id = addresses.id JOIN cities ON cities.id = addresses.city").limit(3).order("users_in_city DESC").group("cities.name")
  end

  def self.top_order
    User.select("users.first_name AS user_first_name, users.last_name AS user_last_name, SUM(purchases.quantity * products.price) AS value").joins("JOIN orders ON users.id = orders.userid JOIN purchases ON orders.id = purchases.order_id JOIN products ON purchases.product_id = products.id").where("orders.checked_out" => true).group("orders.id").order("value DESC").limit(1).first
  end

  def self.highest_lifetime
    User.select("users.first_name AS user_first_name, users.last_name AS user_last_name, SUM(purchases.quantity * products.price) AS value").joins("JOIN orders ON users.id = orders.userid JOIN purchases ON orders.id = purchases.order_id JOIN products ON purchases.product_id = products.id").where("orders.checked_out" => true).group("users.id").order("value DESC").limit(1).first
  end

  def self.highest_average_order
    User.select("users.first_name AS user_first_name, users.last_name AS user_last_name, AVG(purchases.quantity * products.price) AS value").joins("JOIN orders ON users.id = orders.userid JOIN purchases ON orders.id = purchases.order_id JOIN products ON purchases.product_id = products.id").where("orders.checked_out" => true).group("users.id").order("value DESC").limit(1).first
  end

  def self.most_orders
    User.select("users.first_name AS user_first_name, users.last_name AS user_last_name, COUNT(DISTINCT orders.id) AS orders_placed").joins("JOIN orders ON users.id = orders.userid").where("orders.checked_out" => true).group("users.id").order("orders_placed DESC").limit(1).first
  end

  # def self.orders_by_value
  #   User.select("users.first_name AS user_first_name, users.last_name AS user_last_name, SUM(purchases.quantity * products.price) AS value").joins("JOIN orders ON users.id = orders.userid JOIN purchases ON orders.id = purchases.order_id JOIN products ON purchases.product_id = products.id").where("orders.checked_out" => true).group("orders.id").order("value DESC")
  # end

  # def self.highest_average_order
  #   User.orders_by_value.select("users.first_name AS user_first_name, users.last_name AS user_last_name, AVG(value) AS average").group("users.id").order("average DESC").first
  # end

  # def self.highest_average_order
  #   query = "SELECT order_values.uf1 AS user_first_name, order_values.ul1 AS user_last_name, AVG(order_values.ov) AS value

  # #   FROM (SELECT users.id AS users_id, users.first_name AS uf1, users.last_name AS ul1, SUM(purchases.quantity * products.price) AS ov
  # #   FROM users JOIN orders ON users.id = orders.userid
  # #   JOIN purchases ON orders.id = purchases.order_id
  # #   JOIN products ON purchases.product_id = products.id
  # #   WHERE orders.checked_out = 'true'
  # #   GROUP BY orders.id) AS order_values
  # #   GROUP BY order_values.users_id
  # #   ORDER BY value DESC
  # #   "

  #   find_by_sql(query)
  # end

end