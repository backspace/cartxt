class AddPendingPaymentsToSharer < ActiveRecord::Migration
  def change
    add_column :sharers, :pending_payments, :float, default: 0
  end
end
