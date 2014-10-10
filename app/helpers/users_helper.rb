module UsersHelper
  def completed_orders(user)
    user.orders.where(checked_out: true)
  end
end
