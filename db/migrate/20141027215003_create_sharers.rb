class CreateSharers < ActiveRecord::Migration
  def change
    create_table :sharers do |t|
      t.string :number
      t.string :name
      t.string :status
      t.integer :role
      t.timestamps
    end
  end
end
