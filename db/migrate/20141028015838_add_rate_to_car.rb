class AddRateToCar < ActiveRecord::Migration
  def change
    add_column :cars, :rate, :float
  end
end
