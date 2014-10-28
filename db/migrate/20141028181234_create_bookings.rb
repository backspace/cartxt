class CreateBookings < ActiveRecord::Migration
  def change
    create_table :bookings do |t|
      t.references :car, index: true
      t.references :sharer, index: true
      t.datetime :begins_at
      t.datetime :ends_at
      t.timestamps
    end
  end
end
