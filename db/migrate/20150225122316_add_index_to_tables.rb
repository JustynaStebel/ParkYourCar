class AddIndexToTables < ActiveRecord::Migration
  def change
    add_index :cars, :owner_id
    add_index :parkings, :address_id
    add_index :parkings, :owner_id
    add_index :place_rents, :parking_id
    add_index :place_rents, :car_id
  end
end
