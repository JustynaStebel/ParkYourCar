class FixAddressColumn < ActiveRecord::Migration
  def change
    remove_column :addresses, :zipcode, :string
    change_column :addresses, :zip_code, :string
  end
end
