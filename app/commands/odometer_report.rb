module Commands
  class OdometerReport
    def initialize(options)
      @car = options[:car]
      @sharer = options[:sharer]
      @reading = options[:reading]

      @responses = []
    end

    def execute
      @car.odometer_reading = @reading
      @car.save

      @responses.push Response.new(from: @car, to: @sharer, body: "Set odometer reading to #{@reading}")
    end

    def responses
      @responses
    end
  end
end
