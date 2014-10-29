module Responses
  class ReturnFailure < AbstractResponse
    def body
      "The car has already been returned!"
    end
  end
end
