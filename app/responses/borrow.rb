module Responses
  class Borrow < AbstractResponse
    def initialize(options)
      @from = options[:car]
      @to = options[:sharer]
    end

    def body
      "The car is yours! #{NextBookingFormatter.new(car: @from).output}What is the odometer reading?"
    end
  end
end
