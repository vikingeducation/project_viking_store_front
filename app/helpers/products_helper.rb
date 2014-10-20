module ProductsHelper
	def checked_out(arg)
		@product.orders.where(checked_out: arg).count
	end

  def get_product(product_id)
    Product.find(product_id.to_i)
  end
end
