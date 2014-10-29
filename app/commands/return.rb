module Commands
  class Return < AbstractCommand
    def initialize(options)
      super
    end

    def execute
      if car.may_return?
        car.return!

        append_response "Thanks! What is the odometer reading?"
      else
        append_response "The car has already been returned!"
      end
    end
  end
end
