module Commands
  class Abandon < AbstractCommand
    def initialize(options)
      super
      @identifier = options[:identifier]
    end

    def execute
      if @identifier.present?
        index = Parsers::BookingIndex.new(@identifier).parse
        booking = sharer.bookings.upcoming[index]

        if booking
          booking.abandon!
          @responses.push Responses::AbandonExistingBooking.new(car: car, sharer: sharer, booking: booking)
        else
          @responses.push Responses::AbandonExistingBookingNotFoundFailure.new(car: car, sharer: sharer)
        end
      else
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
end

