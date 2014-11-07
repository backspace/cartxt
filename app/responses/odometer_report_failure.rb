module Responses
  class OdometerReportFailure < DynamicResponse
    description "Sent when the proposed odometer reading is lower than the previous reading."

    expose :reading

    default_body "Unable to set odometer reading to {{reading}}, which is lower than the current reading of {{car.odometer_reading}}"
  end
end
