module Responses
  class Borrow < AbstractResponse
    def body
      "The car is yours!#{details} #{NextBookingFormatter.new(car: @from).output}What is the odometer reading?"
    end

    private
    # FIXME
    def details
      appended = []

      appended << @car.location_information if @car.location_information.present?
      appended << @car.lockbox_information if @car.lockbox_information.present?

      if appended.present?
        " #{appended.join " "}"
      else
        ""
      end
    end
  end
end
