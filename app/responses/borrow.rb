module Responses
  class Borrow < AbstractResponse
    def body
      "I am yours!#{details} #{NextBookingFormatter.new(car: @from).output}What is my odometer reading?"
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
