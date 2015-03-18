class ChangeParkingFileTypes < ActiveRecord::Migration
  def change
    remove_column :parkings, :places, :string
    add_column :parkings, :places, :integer
    change_column :parkings, :hour_price, :decimal
    change_column :parkings, :day_price, :decimal
  end
end
