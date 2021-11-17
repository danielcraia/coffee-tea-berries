class ChangeQuantityForCartProducts < ActiveRecord::Migration[6.1]
  def change
    change_column :cart_products, :quantity, :integer, default: 0
  end
end
