class CreateTxts < ActiveRecord::Migration
  def change
    create_table :txts do |t|
      t.string :from
      t.string :to
      t.string :body

      t.timestamps
    end
  end
end
