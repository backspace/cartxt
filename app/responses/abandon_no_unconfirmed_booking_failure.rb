module Responses
  class AbandonNoUnconfirmedBookingFailure < DynamicResponse
    description "Sent when a sharer says 'abandon' but has no booking in progress."

    default_body "Sorry, you have no pending booking to abandon! Try making a booking by sending \"book from X to Y\"."
  end
end
