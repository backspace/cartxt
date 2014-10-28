class CreateBorrowings < ActiveRecord::Migration
  def change
    create_table :borrowings do |t|
      t.references :car
      t.references :sharer
      t.integer :initial
      t.integer :final
      t.timestamps
    end
  end
end
