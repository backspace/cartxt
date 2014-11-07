module Responses
  class Pay < DynamicResponse
    description "Sent when a sharer registers their payment submission."

    expose :amount

    default_body "Place your payment in the lockbox. {{car.lockbox_information | with_conditional_following_space}}After your pending payment of {{amount | as_currency}}, your balance will be {{sender.pending_balance | as_currency}}."
  end
end
