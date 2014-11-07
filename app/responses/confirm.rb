module Responses
  class Confirm < DynamicResponse
    expose :booking, presenter: "Booking"

    def self.default_body
      "You have booked me {{booking.formatted}}. {{car.location_information | with_conditional_following_space}}When the time comes, send \"borrow\"."
    end
  end
end
