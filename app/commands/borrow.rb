module Commands
  class Borrow < AbstractCommand
    def initialize(options)
      super
    end

    def execute
      if car.may_borrow?
        car.borrow!
        @responses.push Responses::Borrow.new(car: car, sharer: sharer)
      else
        @responses.push Responses::BorrowFailure.new(car: car, sharer: sharer)
      end
    end
  end
end
