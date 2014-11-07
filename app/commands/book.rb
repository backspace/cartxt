module Commands
  class Book < AbstractCommand
    def initialize(options)
      super

      @booking_string = options[:booking_string]
    end

    def execute
      parsed_booking = Parsers::Booking.new(@booking_string).parse

      unconfirmed_bookings = Booking.unconfirmed_for(@car, @sharer)

      # FIXME assuming only one

      unconfirmed_booking = unconfirmed_bookings.first

      if unconfirmed_booking
        # FIXME duplication of conflict finding
        conflict_finder = BookingConflictFinder.new(car: car, proposed_booking: parsed_booking, excluding: unconfirmed_booking)

        if conflict_finder.conflict?
          unconfirmed_booking.delete

          @responses.push Responses::BookFailure.new(car: car, sharer: sharer, conflicting_booking: conflict_finder.conflicting_booking)
        else
          unconfirmed_booking.begins_at = parsed_booking.begins_at
          unconfirmed_booking.ends_at = parsed_booking.ends_at
          unconfirmed_booking.save

          @responses.push Responses::BookUpdate.new(car: car, sharer: sharer, booking: unconfirmed_booking)
        end
      else
        conflict_finder = BookingConflictFinder.new(car: car, proposed_booking: parsed_booking)

        if conflict_finder.conflict?
          @responses.push Responses::BookFailure.new(car: car, sharer: sharer, conflicting_booking: conflict_finder.conflicting_booking)
        else
          booking = Booking.create(car: car, sharer: sharer, begins_at: parsed_booking.begins_at, ends_at: parsed_booking.ends_at)

          @responses.push Responses::Book.new(car: car, sharer: sharer, booking: booking)
        end
      end
    end
  end
end
