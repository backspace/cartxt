module Responses
  class Status < AbstractResponse
    def body
      if @car.returned?
        "I am available to borrow!"
      else
        "Sorry, I am being borrowed."
      end
    end
  end
end
