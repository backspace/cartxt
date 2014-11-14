module Responses
  class StatusAvailable < DynamicResponse
    description "Sent in reply to the 'status' command when the car is available."

    default_body "I am available to borrow!"
  end
end
