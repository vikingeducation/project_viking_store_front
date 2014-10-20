class HerokuColumnUpdates < ActiveRecord::Migration
  def up
    change_column :products, :sku, :bigint, null: false
    change_column :products, :price, :decimal, precision: 8, scale: 2, null: false
  end

  def down
    change_column :products, :sku, :integer, null: false
    change_column :products, :price, :decimal, precision: 3, scale: 2, null: false
  end
end
