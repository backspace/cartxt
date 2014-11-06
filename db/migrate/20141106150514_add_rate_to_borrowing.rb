class AddRateToBorrowing < ActiveRecord::Migration
  def change
    add_column :borrowings, :rate, :float
  end
end
