module UsersHelper
  def completed_orders(user)
    user.orders.where(checked_out: true)
  end

  def address_maker(addr)
		"#{addr.street_address}, #{addr.city.name}, #{addr.state.name}, #{addr.zip_code}"

  end
end
