module Commands
  class Book < AbstractCommand
    def initialize(options)
      super

      @booking_string = options[:booking_string]
    end

    def execute
      parsed_booking = Utilities::BookingParser.new(@booking_string).parse

      Booking.create(car: @car, sharer: @sharer, begins_at: parsed_booking.begins_at, ends_at: parsed_booking.ends_at)

      @responses.push Response.new(from: @car, to: @sharer, body: "You have booked the car from #{format_time(parsed_booking.begins_at)} to #{format_time(parsed_booking.ends_at)}.")
    end

    private
    def format_time(time)
      time.strftime("%Y-%m-%e %l:%M%p")
    end
  end
end
