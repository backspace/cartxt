module Responses
  class CancelNoUnconfirmedBookingFailure < AbstractResponse
    def body
      "Sorry, you have no pending booking to cancel! Try making a booking by sending \"book from X to Y\"."
    end
  end
end
