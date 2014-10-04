class User < ActiveRecord::Base

  def self.new_users(last_x_days = nil)
    if last_x_days
      User.where("created_at > ?", Time.now - last_x_days.days).size
    else
      User.all.size
    end
  end

  def self.top_three_states
    User.select("states.name AS state_name, COUNT(*) AS users_in_state").joins("JOIN addresses ON users.billing_id = addresses.id JOIN states ON states.id = addresses.state").limit(3).order("users_in_state DESC").group("states.name")
  end

  def self.top_three_cities
    User.select("cities.name AS city_name, COUNT(*) AS users_in_city").joins("JOIN addresses ON users.billing_id = addresses.id JOIN cities ON cities.id = addresses.city").limit(3).order("users_in_city DESC").group("cities.name")
  end

end

# .order("DESC")

# .select("states.name, COUNT(*) AS users_in_state")

# SELECT State.name, Count (*)
# FROM User JOIN Address ON user.billing_address = address.id
# JOIN State ON state.id = Address.state_id
# GROUP BY state.id
# ORDER BY COUNT(*) DESC
# LIMIT 3