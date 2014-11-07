module Responses
  class PayAdminNotification < DynamicResponse
    description "Sent to an admin when a sharer submits a payment."

    expose :amount

    default_body "{{sender.formatted}} is submitting a payment of {{amount | as_currency }}."

    def initialize(options)
      super
      @to = options[:admin]
    end
  end
end
