module Responses
  class ConfirmNoUnconfirmedBookingFailure < AbstractResponse
    def body
      "Sorry, you have no pending booking to confirm! Try making a booking by sending \"book from X to Y\"."
    end
  end
end
