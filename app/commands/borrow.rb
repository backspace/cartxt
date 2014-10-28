module Commands
  class Borrow < AbstractCommand
    def initialize(options)
      super
    end

    def execute
      if car.may_borrow?
        car.borrow!
        @responses.push Response.new(from: @car, to: @sharer, body: "The car is yours! #{NextBookingFormatter.new(car: @car).output}What is the odometer reading?")
      else
        @responses.push Response.new(from: @car, to: @sharer, body: "The car is already being borrowed!")
      end
    end
  end
end
