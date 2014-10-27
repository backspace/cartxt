module Commands
  class Return < AbstractCommand
    def initialize(options)
      super
    end

    def execute
      @car.status = 'returned'
      @car.save

      @responses.push Response.new(from: @car, to: @sharer, body: "Thanks!")
    end
  end
end
