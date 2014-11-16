module Responses
  class StatusBorrowed < DynamicResponse
    description "Sent in reply to the 'status' command when thecar is being borrowed."

    default_body "Sorry, I am booked until {{car.current_booking.relative_end_time}}."
  end
end
