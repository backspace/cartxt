module Responses
  class Name < AbstractResponse
    def body
      "Nice to meet you, #{@to.name}. Please await admin approval."
    end
  end
end
