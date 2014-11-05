module Responses
  class OdometerReportFailure < DynamicResponse
    expose :reading

    def self.default_body
      "Unable to set odometer reading to {{reading}}, which is lower than the current reading of {{car.odometer_reading}}"
    end
  end
end
