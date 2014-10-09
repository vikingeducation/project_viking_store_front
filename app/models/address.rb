class Address < ActiveRecord::Base
  belongs_to :city
  belongs_to :state
  belongs_to :user

  has_one :billing, :class_name => "User"
  has_one :shipping, :class_name => "User"
end
