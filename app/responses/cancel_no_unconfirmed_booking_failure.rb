module Responses
  class CancelNoUnconfirmedBookingFailure < DynamicResponse
    description "Sent when a sharer says 'cancel' but has no booking in progress."

    default_body "Sorry, you have no pending booking to cancel! Try making a booking by sending \"book from X to Y\"."
  end
end
