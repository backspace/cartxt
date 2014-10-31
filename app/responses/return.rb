module Responses
  class Return < AbstractResponse
    def body
      "Thanks for the ride! #{afterspace_potential_content([@car.location_information, @car.lockbox_information])}What is my odometer reading?"
    end
  end
end
