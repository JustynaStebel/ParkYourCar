class CreateParkings < ActiveRecord::Migration
  def change
    create_table :parkings do |t|
      t.string :places
      t.string :kind
      t.integer :hour_price
      t.integer :day_price
      t.integer :address_id
      t.integer :owner_id

      t.timestamps null: false
    end
  end
end

