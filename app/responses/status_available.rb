module Responses
  class StatusAvailable < DynamicResponse
    description "Sent in reply to the 'status' command when the car is available."

    default_body "I am available to borrow!{% if car.upcoming_booking? %} My next booking begins {{car.next_booking.relative_beginning_time}}.{% endif %}"
  end
end
