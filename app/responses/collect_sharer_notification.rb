module Responses
  class CollectSharerNotification < DynamicResponse
    expose :amount

    default_body "Your payment of {{amount | as_currency}} has been received. Your balance owing is now {{sender.balance | as_currency}}."
  end
end
