class CreateAddresses < ActiveRecord::Migration[7.2]
  def change
    create_table :addresses do |t|
      t.string :street_address
      t.string :landmark
      t.string :city
      t.string :state
      t.string :country
      t.integer :pincode
      t.references :addressable, polymorphic: true, null: false

      t.timestamps
    end
  end
end
