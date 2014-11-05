module Responses
  class Borrow < DynamicResponse
    def self.default_body
      "I am yours! {{car.location_information | with_conditional_following_space}}{{car.lockbox_information | with_conditional_following_space }}{{car.next_booking | with_conditional_following_space }}What is my odometer reading?"
    end
  end
end
