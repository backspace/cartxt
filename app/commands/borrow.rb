module Commands
  class Borrow
    def initialize(options)
      @car = options[:car]
      @sharer = options[:sharer]

      @responses = []
    end

    def execute
      @car.status = 'borrowed'
      @car.save

      @responses.push Response.new(from: @car, to: @sharer, body: "The car is yours!")
    end

    def responses
      @responses
    end
  end
end
