module Commands
  class Return < AbstractCommand
    def initialize(options)
      super
    end

    def execute
      if @car.status == 'returned'
        @responses.push Response.new(from: @car, to: @sharer, body: "The car has already been returned!")
      else
        @car.status = 'returned'
        @car.save

        @responses.push Response.new(from: @car, to: @sharer, body: "Thanks!")
      end
    end
  end
end
