module Responses
  class BookConflictFailure < DynamicResponse
    description "Sent when a booking is blocked by an existing booking that overlaps with the proposed one."

    expose :conflicting_booking, presenter: "Booking"

    default_body "Sorry, the car is already booked {{conflicting_booking.formatted}}."
  end
end
