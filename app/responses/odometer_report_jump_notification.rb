module Responses
  class OdometerReportJumpNotification < DynamicResponse
    description "Sent to admins when an odometer reading at the beginning of a borrowing is higher than the reading from the end of the last borrowing."

    expose :borrower, presenter: "Sharer"
    expose :reading
    expose :original_reading

    default_body "{{borrower.name}} is borrowing the car and reports the odometer reading is {{reading}} when it was last known to be {{original_reading}}. Hmm."
  end
end
