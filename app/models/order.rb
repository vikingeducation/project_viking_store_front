class Order < ActiveRecord::Base

  def self.new_orders(last_x_days = nil)
    if last_x_days
      Order.where("checkout_date > ?", Time.now - last_x_days.days).size
    else
      Order.all.size
    end
  end

end
