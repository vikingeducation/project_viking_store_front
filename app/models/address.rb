class Address < ActiveRecord::Base
  belongs_to :city
  belongs_to :state
  belongs_to :user

  has_many :orders, foreign_key: :billing_id, :class_name => "Order"

  has_one :default_billing, foreign_key: :billing_id, :class_name => "User"
  has_one :default_shipping, foreign_key: :shipping_id, :class_name => "User"

  validates :street_address,
            :zip_code,
            :city_id,
            :state_id,
            :user_id, :presence => true
end
