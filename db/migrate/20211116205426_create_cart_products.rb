class CreateCartProducts < ActiveRecord::Migration[6.1]
  def change
    create_table :cart_products do |t|
      t.belongs_to :product
      t.belongs_to :cart
      t.integer    :quantity

      t.timestamps
    end
  end
end
