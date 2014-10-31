module Responses
  class BorrowFailure < AbstractResponse
    def body
      "Sorry, I am already being borrowed!"
    end
  end
end
