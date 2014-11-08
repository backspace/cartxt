module Services
  class DeletesUnconfirmedBookings
    def initialize(car, sharer)
      @car = car
      @sharer = sharer
    end

    def delete_unconfirmed_bookings
      Booking.unconfirmed_for(@car, @sharer).each do |booking|
        booking.delete
      end
    end
  end
end
