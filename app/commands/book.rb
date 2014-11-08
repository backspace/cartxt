module Commands
  class Book < AbstractCommand
    def initialize(options)
      super

      @booking_string = options[:booking_string]
    end

    def execute
      parsed_booking = Parsers::Booking.new(@booking_string).parse

      Services::DeletesUnconfirmedBookings.new(@car, @sharer).delete_unconfirmed_bookings

      validator = Validators::Booking.new(car: car, booking: parsed_booking)

      if validator.valid?
        booking = Booking.create(car: car, sharer: sharer, begins_at: parsed_booking.begins_at, ends_at: parsed_booking.ends_at)

        @responses.push Responses::Book.new(car: car, sharer: sharer, booking: booking)
      else
        Responses::Generators::BookFailure.new(car: car, sharer: sharer, validator: validator).responses.each do |response|
          @responses.push response
        end
      end
    end
  end
end
