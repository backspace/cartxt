module Responses
  class Borrow < AbstractResponse
    def body
      "I am yours! #{afterspace_potential_content([@car.location_information, @car.lockbox_information, Formatters::NextBooking.new(car: @from).output])}What is my odometer reading?"
    end
  end
end
