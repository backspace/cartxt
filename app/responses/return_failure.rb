module Responses
  class ReturnFailure < DynamicResponse
    description "Sent when someone tries to return a car that has not been borrowed."
    default_body "The car has already been returned!"
  end
end
