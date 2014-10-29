module Responses
  class BorrowFailure < AbstractResponse
    def body
      "The car is already being borrowed!"
    end
  end
end
