module OrderContentsHelper

  def get_total_price(cart)
    total = 0
      cart.each do |item,quantity|
        price = Product.find(item).price
        total+= (price * quantity.to_i)
      end
      total
  end
end
