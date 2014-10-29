module Commands
  class Return < AbstractCommand
    def initialize(options)
      super
    end

    def execute
      if car.may_return?
        car.return!

        @responses.push Responses::Return.new(car: car, sharer: sharer)
      else
        @responses.push Responses::ReturnFailure.new(car: car, sharer: sharer)
      end
    end
  end
end
