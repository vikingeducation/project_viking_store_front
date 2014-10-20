class ChangeCc < ActiveRecord::Migration
  def change
    change_table :payments do |o|
      o.change :cc_number, :string
    end
  end
end
