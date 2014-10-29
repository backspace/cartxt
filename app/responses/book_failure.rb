module Responses
  class BookFailure < AbstractResponse
    def initialize(options)
      super
      @conflicting_booking = options[:conflicting_booking]
    end

    def body
      "Sorry, the car is already booked from #{@conflicting_booking.begins_at.to_formatted_s} to #{@conflicting_booking.ends_at.to_formatted_s}."
    end
  end
end
