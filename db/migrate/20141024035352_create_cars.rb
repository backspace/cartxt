class CreateCars < ActiveRecord::Migration
  def change
    create_table :cars do |t|
      t.integer :odometer_reading

      t.timestamps
    end
  end
end
