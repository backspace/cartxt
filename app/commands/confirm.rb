module Commands
  class Confirm < AbstractCommand
    def execute
      unconfirmed_bookings = Booking.unconfirmed_for(@car, @sharer)

      # FIXME assuming only one

      unconfirmed_booking = unconfirmed_bookings.first

      if unconfirmed_booking
        unconfirmed_booking.confirm!

        @responses.push Responses::Confirm.new(car: car, sharer: sharer, booking: unconfirmed_booking)
      else
        @responses.push Responses::ConfirmNoUnconfirmedBookingFailure.new(car: car, sharer: sharer)
      end
    end
  end
end
