class User < ActiveRecord::Base

  def self.new_users(last_x_days = nil)
    if last_x_days
      User.where("created_at > ?", Time.now - last_x_days.days).size
    else
      User.all.size
    end
  end

end
