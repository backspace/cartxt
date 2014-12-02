module Responses
  class BookPastFailure < DynamicResponse
    description "Sent when a sharer tries to book the car in the past."

    expose :booking, presenter: "Booking"

    default_body "Sorry, you cannot book the car in the past. You tried to book {{booking.formatted}}."
  end
end
