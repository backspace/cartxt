module Commands
  class Status
    def initialize(options)
      @car = options[:car]
      @sharer = options[:sharer]

      @responses = []
    end

    def execute
      @responses.push Response.new(from: @car, to: @sharer, body: "The odometer reading is #{@car.odometer_reading}")
    end

    def responses
      @responses
    end
  end
end
