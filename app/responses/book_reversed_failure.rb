module Responses
  class BookReversedFailure < DynamicResponse
    description "Sent when a sharer tries to make a booking where the end is before the beginning."

    expose :booking, presenter: "Booking"

    default_body "Sorry, you cannot make a booking where the end is before the beginning. You tried to book me {{booking.formatted}}."
  end
end
