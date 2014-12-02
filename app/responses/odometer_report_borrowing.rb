module Responses
  class OdometerReportBorrowing < DynamicResponse
    description "Sent at the beginning of a borrowing when a sharer updates the odometer reading."

    default_body "Updated the records with a reading of {{car.odometer_reading}}km. When finished, just say \"return\". If you buy gas, say \"gas 25.50\" or however much you spend, and make sure to save the receipt."
  end
end
