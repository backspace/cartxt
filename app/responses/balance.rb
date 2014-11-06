module Responses
  class Balance < DynamicResponse
    def self.default_body
      "Your balance is {{sender.balance | as_currency}}, with pending payments of {{sender.pending_payments | as_currency}}."
    end
  end
end
