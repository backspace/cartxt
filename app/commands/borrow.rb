module Commands
  class Borrow < AbstractCommand
    def initialize(options)
      super
    end

    def execute
      if car.may_borrow?
        car.borrow!
        append_response "The car is yours! #{NextBookingFormatter.new(car: car).output}What is the odometer reading?"
      else
        append_response "The car is already being borrowed!"
      end
    end
  end
end
