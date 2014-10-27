module Commands
  class OdometerReport < AbstractCommand
    def initialize(options)
      super

      @reading = options[:reading]
    end

    def execute
      @car.odometer_reading = @reading
      @car.save

      @responses.push Response.new(from: @car, to: @sharer, body: "Set odometer reading to #{@reading}")
    end
  end
end
