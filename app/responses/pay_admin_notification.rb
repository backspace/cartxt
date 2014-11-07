module Responses
  class PayAdminNotification < DynamicResponse
    expose :amount

    def initialize(options)
      super
      @to = options[:admin]
    end

    def self.default_body
      "{{sender.formatted}} is submitting a payment of {{amount | as_currency }}."
    end
  end
end
