class AddLocationInformationToCar < ActiveRecord::Migration
  def change
    add_column :cars, :location_information, :string
    add_column :cars, :lockbox_information, :string
  end
end
