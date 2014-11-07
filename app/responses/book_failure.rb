module Responses
  class BookFailure < DynamicResponse
    expose :conflicting_booking, presenter: "Booking"

    def self.default_body
      "Sorry, I am already booked {{conflicting_booking.formatted}}."
    end
  end
end
