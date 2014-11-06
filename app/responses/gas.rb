module Responses
  class Gas < DynamicResponse
    expose :cost

    def self.default_body
      "Deducted your gas cost of {{cost | as_currency }}. Your pending balance is now {{sender.pending_balance | as_currency}}. Please submit the receipt when you return the key."
    end
  end
end
