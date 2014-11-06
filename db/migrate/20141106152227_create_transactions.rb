class CreateTransactions < ActiveRecord::Migration
  def change
    create_table :transactions do |t|
      t.float :amount
      t.references :origin, index: true, polymorphic: true
      t.references :sharer, index: true
      t.timestamps
    end
  end
end
