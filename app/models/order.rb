class Order < ActiveRecord::Base

  def self.new_orders(last_x_days = nil)
    if last_x_days
      Order.where("checkout_date > ?", Time.now - last_x_days.days).size
    else
      Order.all.size
    end
  end

  def self.largest_value(last_x_days = nil)
    if last_x_days
      Order.select("SUM(purchases.quantity * products.price) AS value").joins("JOIN purchases ON orders.id = purchases.order_id JOIN products ON products.id = purchases.product_id").where("checkout_date > ?", Time.now - last_x_days.days).order("value DESC").group("orders.id").first.value
    else
      Order.select("SUM(purchases.quantity * products.price) AS value").joins("JOIN purchases ON orders.id = purchases.order_id JOIN products ON products.id = purchases.product_id").order("value DESC").group("orders.id").first.value
    end
  end

  def self.orders_on(days_ago)
    Order.where(:checkout_date => ((Time.now.midnight - days_ago.days)..(Time.now.midnight + 1.days - days_ago.days))).size
  end

  def self.daily_revenue(days_ago)
    Order.joins("JOIN purchases ON orders.id = purchases.order_id JOIN products ON purchases.product_id = products.id").where(:checkout_date => ((Time.now.midnight - days_ago.days)..(Time.now.midnight + 1.days - days_ago.days))).sum("(purchases.quantity * products.price)")
  end
end
