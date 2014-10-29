module Responses
  class Status < AbstractResponse
    def body
      "The odometer reading is #{@car.odometer_reading}"
    end
  end
end
