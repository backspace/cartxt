module Responses
  class ConfirmNoUnconfirmedBookingFailure < DynamicResponse
    description "Sent when a sharer sends 'confirm' but has no booking in progress."

    def self.default_body
      "Sorry, you have no pending booking to confirm! Try making a booking by sending \"book from X to Y\"."
    end
  end
end
