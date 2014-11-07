module Responses
  class Borrow < DynamicResponse
    description "Sent when the sharer has borrowed the car."

    default_body "I am yours! My current rate is {{car.rate | as_currency}}/km. {{car.location_information | with_conditional_following_space}}{{car.lockbox_information | with_conditional_following_space }}{{car.next_booking | with_conditional_following_space }}What is my odometer reading?"
  end
end
