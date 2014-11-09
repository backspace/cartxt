module Responses
  class ReturnNotBorrowerFailure < DynamicResponse
    description "Sent when someone tries to return a car they are not borrowing."
    default_body "You are not borrowing me!"
  end
end
