module Commands
  class Return < AbstractCommand
    def initialize(options)
      super
    end

    def execute
      if car.may_return?
        car.return!

        @responses.push Response.new(from: @car, to: @sharer, body: "Thanks!")
      else
        @responses.push Response.new(from: @car, to: @sharer, body: "The car has already been returned!")
      end
    end
  end
end
