class CreditCard < ActiveRecord::Base
  has_many :orders

  belongs_to :user

  def expiration_date
    "#{exp_month}\/#{exp_year}"
  end
end
