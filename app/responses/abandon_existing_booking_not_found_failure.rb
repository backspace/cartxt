module Responses
  class AbandonExistingBookingNotFoundFailure < DynamicResponse
    description "Sent when a sharer tries to abandon a booking but it is not found."

    default_body "Booking not found."
  end
end
