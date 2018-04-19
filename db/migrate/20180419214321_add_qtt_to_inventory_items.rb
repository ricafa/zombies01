class AddQttToInventoryItems < ActiveRecord::Migration[5.0]
  def change
    add_column :inventory_items, :qtt, :integer, default: 1
  end
end
