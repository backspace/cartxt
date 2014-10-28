class AddBalanceToSharer < ActiveRecord::Migration
  def change
    add_column :sharers, :balance, :float, default: 0
  end
end
