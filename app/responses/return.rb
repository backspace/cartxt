module Responses
  class Return < DynamicResponse
    description "Sent when a sharer returns the car."

    default_body "{{car.location_information | with_conditional_following_space }}{{car.lockbox_information | with_conditional_following_space }}What is the odometer reading?"
  end
end
