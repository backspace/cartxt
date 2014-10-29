module Commands
  class Book < AbstractCommand
    def initialize(options)
      super

      @booking_string = options[:booking_string]
    end

    def execute
      parsed_booking = Utilities::BookingParser.new(@booking_string).parse

      booking = Booking.create(car: car, sharer: sharer, begins_at: parsed_booking.begins_at, ends_at: parsed_booking.ends_at)

      @responses.push Responses::Book.new(car: car, sharer: sharer, booking: booking)
    end
  end
end
