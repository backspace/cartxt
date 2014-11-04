module Responses
  class BorrowFailure < DynamicResponse
    def default_body
      "Sorry, I am already being borrowed!"
    end
  end
end
