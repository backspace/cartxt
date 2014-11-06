module Responses
  class CollectSharerNotification < DynamicResponse
    expose :amount

    def self.default_body
      "Your payment of {{amount | as_currency}} has been received. Your balance is now {{sender.balance | as_currency}}."
    end
  end
end
