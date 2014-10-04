class Product < ActiveRecord::Base

  def self.new_products(last_x_days = nil)
    if last_x_days
      Product.where("created_at > ?", Time.now - last_x_days.days).size
    else
      Product.all.size
    end
  end

end
