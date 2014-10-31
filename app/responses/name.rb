module Responses
  class Name < AbstractResponse
    def body
      "Nice to meet you, #{@to.name}. Please wait while I check in."
    end
  end
end
