module Responses
  class Return < DynamicResponse
    default_body "Thanks for the ride! {{car.location_information | with_conditional_following_space }}{{car.lockbox_information | with_conditional_following_space }}What is my odometer reading?"
  end
end
