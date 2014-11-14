module Commands
  class Until < AbstractCommand
    def initialize(options)
      super
      @until_string = options[:until_string]
    end

    def execute
      booking = Booking.new(car: car, sharer: sharer, begins_at: Time.now, ends_at: Parsers::FutureTime.new(@until_string).parse)

      validator = Validators::Booking.new(car: car, booking: booking, exception: :past)

      if validator.valid?
        booking.save
        booking.confirm

        borrow = Borrow.new(car: car, sharer: sharer)
        borrow.execute
        @responses = borrow.responses
      end
    end
  end
end
