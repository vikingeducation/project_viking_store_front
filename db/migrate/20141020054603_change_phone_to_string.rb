class ChangePhoneToString < ActiveRecord::Migration
  def change
    change_table :users do |o|
      o.change :phone, :string
    end
  end
end
