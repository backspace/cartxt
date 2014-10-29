module Commands
  class Book < AbstractCommand
    def initialize(options)
      super

      @booking_string = options[:booking_string]
    end

    def execute
      parsed_booking = Utilities::BookingParser.new(@booking_string).parse

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
