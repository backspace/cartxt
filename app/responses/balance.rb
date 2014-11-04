module Responses
  class Balance < DynamicResponse
    def self.default_body
      "Your current balance is {{sender.balance | as_currency}}."
    end
  end
end
