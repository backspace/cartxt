module Responses
  class BookFailure < AbstractResponse
    def initialize(options)
      super
      @conflicting_booking = options[:conflicting_booking]
    end

    def body
      "Sorry, I am already booked #{Formatters::Booking.new(@conflicting_booking).format}."
    end
  end
end
