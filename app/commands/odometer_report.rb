module Commands
  class OdometerReport < AbstractCommand
    def initialize(options)
      super

      @reading = options[:reading]
    end

    def execute
      begin
        @car.accept_report!(nil, @reading)

        @responses.push Response.new(from: @car, to: @sharer, body: "Set odometer reading to #{@reading}")
      rescue InvalidOdometerReadingException
        @responses.push Response.new(from: @car, to: @sharer, body: "Unable to set odometer reading to #{@reading}, which is lower than the current reading of #{@car.odometer_reading}")
      end
    end
  end
end
