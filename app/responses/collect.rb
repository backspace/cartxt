module Responses
  class Collect < DynamicResponse
    expose :amount
    expose :collectee, class: Presenters::Sharer

    def initialize(options)
      super
      @to = options[:admin]
    end

    def self.default_body
      "Deducted {{amount | as_currency}} from the balance of {{collectee.formatted}}. Their balance is now {{collectee.balance | as_currency }}."
    end
  end
end
