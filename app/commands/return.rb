module Commands
  class Return
    def initialize(options)
      @car = options[:car]
      @sharer = options[:sharer]

      @responses = []
    end

    def execute
      @car.status = 'returned'
      @car.save

      @responses.push Response.new(from: @car, to: @sharer, body: "Thanks!")
    end

    def responses
      @responses
    end
  end
end
