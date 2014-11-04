module Responses
  class ReturnFailure < DynamicResponse
    description "Sent when someone tries to return a car that has not been borrowed."

    def self.default_body
      "The car has already been returned!"
    end
  end
end
