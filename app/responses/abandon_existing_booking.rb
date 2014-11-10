module Responses
  class AbandonExistingBooking < DynamicResponse
    description "Sent when a sharer abandons a booking they already confirmed."

    expose :booking, presenter: "Booking"

    default_body "Abandoned your booking {{ booking.formatted }}."
  end
end
