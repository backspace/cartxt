class AddEmailToSharer < ActiveRecord::Migration
  def change
    add_column :sharers, :email, :string
  end
end
