class CreditCard < ActiveRecord::Base
  has_many :orders

  belongs_to :user

  validates :card_number,
            :exp_month,
            :exp_year,
            :user_id,
            :ccv, presence: true

  validates_presence_of :user

  def expiration_date
    "#{exp_month}\/#{exp_year}"
  end
end
