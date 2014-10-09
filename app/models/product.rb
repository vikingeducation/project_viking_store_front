class Product < ActiveRecord::Base
  belongs_to :category
  has_many :orders, through: :purchases

  def self.new_products(last_x_days = nil)
    if last_x_days
      where("created_at > ?", Time.now - last_x_days.days).size
    else
      all.size
    end
  end

end
