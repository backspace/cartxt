module Responses
  class OdometerReportFailure < AbstractResponse
    def initialize(options)
      super
      @reading = options[:reading]
    end

    def body
      "Unable to set odometer reading to #{@reading}, which is lower than the current reading of #{@car.odometer_reading}"
    end
  end
end
