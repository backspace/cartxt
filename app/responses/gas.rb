module Responses
  class Gas < DynamicResponse
    description "Sent when a sharer has registered a gas purchase."

    expose :cost

    default_body "Deducted your gas cost of {{cost | as_currency}}. Your pending balance owing is now {{sender.pending_balance | as_currency}}. Please submit the receipt when you return the key."
  end
end
