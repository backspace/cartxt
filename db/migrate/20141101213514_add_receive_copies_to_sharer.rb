class AddReceiveCopiesToSharer < ActiveRecord::Migration
  def change
    add_column :sharers, :receive_copies, :boolean
  end
end
