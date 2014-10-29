module Commands
  class Book < AbstractCommand
    def initialize(options)
      super

      @booking_string = options[:booking_string]
    end

    def execute
      parsed_booking = Utilities::BookingParser.new(@booking_string).parse

      Booking.create(car: car, sharer: sharer, begins_at: parsed_booking.begins_at, ends_at: parsed_booking.ends_at)

      @responses.push Response.new(from: car, to: sharer, body: "You have booked the car from #{parsed_booking.begins_at.to_formatted_s} to #{parsed_booking.ends_at.to_formatted_s}.")
    end
  end
end
