module Responses
  class Collect < DynamicResponse
    description "Sent when an admin has recorded receiving a payment."

    expose :amount
    expose :collectee, presenter: "Sharer"

    default_body "Deducted {{amount | as_currency}} from the balance of {{collectee.formatted}}. Their balance is now {{collectee.balance | as_currency }}."

    def initialize(options)
      super
      @to = options[:admin]
    end
  end
end
