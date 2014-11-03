module Responses
  class ReturnFailure < DynamicResponse
    def default_body
      "The car has already been returned!"
    end
  end
end
