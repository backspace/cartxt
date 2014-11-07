module Responses
  class Balance < DynamicResponse
    description "Sent when a sharer asks for their balance."

    default_body "Your balance owing is {{sender.balance | as_currency}}, with pending payments of {{sender.pending_payments | as_currency}}."
  end
end
