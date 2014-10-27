class AddStatusToCar < ActiveRecord::Migration
  def change
    add_column :cars, :status, :string
  end
end
