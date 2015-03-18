class FixCarFileTypes < ActiveRecord::Migration
  def change
    change_column :cars, :registration_number, :string
  end
end
