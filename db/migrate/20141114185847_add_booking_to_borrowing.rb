class AddBookingToBorrowing < ActiveRecord::Migration
  def change
    add_reference :borrowings, :booking, index: true
  end
end
