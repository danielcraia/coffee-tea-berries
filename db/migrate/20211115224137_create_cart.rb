class CreateCart < ActiveRecord::Migration[6.1]
  def change
    create_table :carts do |t|
      t.string :name, presence: true

      t.timestamps
    end
  end
end
