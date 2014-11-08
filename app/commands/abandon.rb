module Commands
  class Abandon < AbstractCommand
    def execute
      unconfirmed_bookings = Booking.unconfirmed_for(@car, @sharer)

      # FIXME assuming only one

      unconfirmed_booking = unconfirmed_bookings.first

      if unconfirmed_booking
        unconfirmed_booking.abandon!

        @responses.push Responses::Abandon.new(car: car, sharer: sharer, booking: unconfirmed_booking)
      else
        @responses.push Responses::AbandonNoUnconfirmedBookingFailure.new(car: car, sharer: sharer)
      end
    end
  end
end

