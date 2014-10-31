module Commands
  class Confirm < AbstractCommand
    def execute
      unconfirmed_bookings = Booking.unconfirmed_for(@car, @sharer)

      # FIXME assuming only one

      unconfirmed_booking = unconfirmed_bookings.first

      if unconfirmed_booking
        unconfirmed_booking.confirm!

        @responses.push Responses::Confirm.new(car: car, sharer: sharer, booking: unconfirmed_booking)
        Sharer.admin.notify_of_bookings.each do |admin|
          @responses.push Responses::ConfirmAdminNotification.new(car: car, booker: sharer, admin: admin, booking: unconfirmed_booking)
        end
      else
        @responses.push Responses::ConfirmNoUnconfirmedBookingFailure.new(car: car, sharer: sharer)
      end
    end
  end
end
