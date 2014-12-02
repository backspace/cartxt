module Responses
  class BorrowFailure < DynamicResponse
    description "Sent when the sender tries to borrow the car but it is already borrowed."

    default_body "Sorry, the car is already being borrowed!"
  end
end
