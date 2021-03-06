module Responses
  class Borrow < DynamicResponse
    description "Sent when the sharer has borrowed the car."

    expose :booking, presenter: "Booking"

    default_body "The car is yours until {{booking.relative_end_time}}. The current rate is {{car.rate | as_currency}}/km. {{car.location_information | with_conditional_following_space}}{{car.lockbox_information | with_conditional_following_space }}What is the odometer reading?"
  end
end
