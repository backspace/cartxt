class AddNumberToCar < ActiveRecord::Migration
  def change
    add_column :cars, :number, :string
  end
end
