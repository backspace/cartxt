module Responses
  class Confirm < DynamicResponse
    description "Sent after a sharer has confirmed their booking."

    expose :booking, presenter: "Booking"

    default_body "You have booked the car {{booking.formatted}}. {{car.location_information | with_conditional_following_space}}When the time comes, send \"borrow\"."
  end
end
