class AddIndexToForeignKeysAndChangeQuantity < ActiveRecord::Migration[6.1]
  def change
    change_column :cart_products, :quantity, :integer, default: 1
    add_index :cart_products, [:cart_id, :product_id]
  end
end
