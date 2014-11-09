module Commands
  class OdometerReport < AbstractCommand
    def initialize(options)
      super

      @reading = options[:reading]
    end

    def execute
      original_reading = car.odometer_reading

      begin
        car.accept_report!(nil, @reading)

        if car.borrowed?
          delegate = OdometerReportBorrowing.new(car: car, sharer: sharer, original_reading: original_reading, reading: @reading)
        else
          delegate = OdometerReportReturning.new(car: car, sharer: sharer, reading: @reading)
        end

        delegate.execute
        @responses = delegate.responses
      rescue InvalidOdometerReadingException
        @responses.push Responses::OdometerReportFailure.new(car: car, sharer: sharer, reading: @reading)
      end
    end
  end
end
