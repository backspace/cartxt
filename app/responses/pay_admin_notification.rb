module Responses
  class PayAdminNotification < DynamicResponse
    expose :amount

    default_body "{{sender.formatted}} is submitting a payment of {{amount | as_currency }}."

    def initialize(options)
      super
      @to = options[:admin]
    end
  end
end
