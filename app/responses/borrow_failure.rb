module Responses
  class BorrowFailure < DynamicResponse
    description "Sent when the sender tries to borrow the car but it is already borrowed."

    default_body "Sorry, I am already being borrowed!"
  end
end
