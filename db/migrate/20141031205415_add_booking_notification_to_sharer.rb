class AddBookingNotificationToSharer < ActiveRecord::Migration
  def change
    add_column :sharers, :notify_of_bookings, :boolean
  end
end
