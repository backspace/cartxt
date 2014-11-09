module Responses
  class OdometerReportReturning < DynamicResponse
    description "Sent at the end of a borrowing when a sharer updates the odometer reading."

    expose :borrowing, presenter: "Borrowing"

    default_body "Thanks, I updated the records with a reading of {{car.odometer_reading}}km. Wow, we drove {{borrowing.span}}km! That brings your balance to {{sender.balance | as_currency }}."
  end
end

