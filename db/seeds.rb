

# Make sure your seeds file blows away any existing models every time it starts running: JUST RUN THIS WITH RAKE db:reset






# Make everything dynamic so you can just specify (hard code) a single "seed multiplier", e.g. 1 or 4 or 20 and it will scale up the size of all your seeds by that factor. This can be useful if you want to start with a very small seed but then ramp up to a huge database for performance testing.

SEED_MULTIPLIER = 1




# Have at least 100 users. Stagger their join dates any time in the last year. Show growth in the rate of user signups over time.
0.upto(100 * SEED_MULTIPLIER) do |number|
  u = User.new
  u.id = number
  u.first_name = Faker::Name.first_name
  u.last_name = Faker::Name.last_name
  u.email = Faker::Internet.email
  u.save
end



# Have at least 100 cities, some associated with addresses and others not. Try to clump addresses into cities so some cities will contain many users/orders.

num_cities = 100 * SEED_MULTIPLIER

0.upto(num_cities) do |number|
  c = City.new
  c.id = number
  c.name = Faker::Address.city
  c.save
end



# Have 5-10 states. You don't need to fluctuate this with your "seed multiplier" below.

0.upto(5) do |i|
  s = State.new
  s.name = Faker::Address.state
  s.save
end



# users should have any number from 0 to 5 addresses listed, as well as one designated the default "shipping" and one the default "billing" (can be the same). Each order has to have an address assigned for "shipping" and "billing", so these defaults are autopopulated if the user doesn't override as part of the checkout process (like Amazon.com). The other addresses are just there as potential options for future orders.

#need to iterate through users via #pop
u = User.all.to_a

#even split among 0..5 addresses
0.upto(5) do |num_addresses|

  #make that certain number of addresses for 1/6 of the users
  (u.size / 6).times do

    #for an individual user, make them num_addresses addresses
    num_addresses.times do
      a = Address.new
      a.street_address = Faker::Address.street_address
      a.secondary_address = Faker::Address.secondary_address
      a.zip_code = Faker::Address.zip_code
      a.phone_number = Faker::PhoneNumber.phone_number
      a.city = 0 #setting these later
      a.state = 0 #setting these later
      a.user_id = u.last.id #the user on top of the stack
      a.save
    end #num_addresses.times

    u.pop #make way for the next user

  end #u.size / 6.times

end #0.upto(5)




#create 50/25/12/6/3/2/1 split for cities, states

percent = 50
id = 1

while percent > 1 do
  (percent * SEED_MULTIPLIER).times do
    a = Address.find_by_city(0)
    a.city = id
    a.state = id
    a.save
  end

  #iterate both the percentage and the city/state id
  percent /= 2
  id += 1
end

#for iterating
users = User.all.to_a

#find all of each user's addresses and set billing/shipping defaults
users.each do |user|
  u_addresses = Address.where(:user_id => user.id)

  if u_addresses.any?
    user.billing_id = u_addresses.first.id
    user.shipping_id = u_addresses.last.id
    user.save
  else
    #skip it to avoid errors
  end
end



# Have 10-30 products across a half-dozen-or-so categories


#sets everything but the category
num_products = 20 * SEED_MULTIPLIER 

0.upto(num_products-1) do |pid|
  product = Product.new
  product.id = pid
  product.name = Faker::Commerce.product_name
  product.price = Faker::Commerce.price
  product.sku = Faker::Code.ean
  product.description = Faker::Lorem.paragraph
  product.category_id = 0
  product.save
end

#creates the categories
num_categories = 6 * SEED_MULTIPLIER

0.upto(num_categories-1) do |cid|
  c = Category.new
  c.id = cid
  c.name = Faker::Commerce.department(2)
  c.description = Faker::Lorem.paragraph
  c.save

  #1/6 of products set to each category
  (num_products / 6).times do
    product = Product.find_by_category_id(0)
    if product
      product.category_id = cid
      product.save
    end
  end

end





# populate a historical record of at least 100 orders staggered throughout the past year. Show growth in the rate of orders over time.
#populate at least 25 shopping carts

num_orders = 125 * SEED_MULTIPLIER

0.upto(num_orders-1) do |order_id|
  o = Order.new
  o.userid = 0 #will change outside this loop

  #shopping carts are just orders not yet checked out
  o.checked_out = false if order_id < ( num_orders / 5 )

  o.save
end


mins = 525949 #minutes in a year
orders = Order.all

#show growth in the rate of orders over time
orders.each do |order|
  order.checkout_date = Time.now - mins.minutes
  order.save

  #every time this iterates, date offset moves closer to the present
  #curve moves slowly, more slowly the more records there are
  mins = mins * 95 / 100 / SEED_MULTIPLIER
end



u = User.all

#loop through all the shopping carts unassigned
user_index = 0
while Order.find_by(:checked_out => false, :userid => 0)
  o = Order.find_by(:checked_out => false, :userid => 0)
  o.userid = user_index
  o.save
  user_index += 1 #make sure no user gets 2 carts
end

user_index = 0
#loop through all orders unassigned to a user
while Order.find_by(:checked_out => true, :userid => 0)
  order = Order.find_by(:checked_out => true, :userid => 0)
  
  #if the user with specified index has a shipping and billing address entered,
  #claim it for this order
  if u[user_index].shipping_id && u[user_index].billing_id
    order.userid = user_index
    order.shipping_id = u[user_index].shipping_id
    order.billing_id = u[user_index].billing_id
    order.save
  end
  
  user_index += 2 #iterate through users so only some have carts AND orders
  user_index = 0 if user_index >= u.size
end


#create 3 times as many purchases as orders
0.upto(orders.size) do |order_id|
  3.times do 
    purchase = Purchase.new
    
    purchase.order_id = order_id
    purchase.product_id = order_id % num_products #unpredictable, not random, spreads across all products
    purchase.quantity = (order_id % 10) + 1  #unpredictable, but not random, and 1 - 10
    purchase.save
  end
end


