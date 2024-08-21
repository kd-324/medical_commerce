class CreateSkus < ActiveRecord::Migration[7.2]
  def change
    create_table :skus do |t|
      t.string :name
      t.string :description
      t.float :price
      t.integer :quantity
      t.boolean :is_otc

      t.timestamps
    end
    add_index :skus, :name, unique: true
  end
end
