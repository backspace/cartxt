module Responses
  class Gas < AbstractResponse
    def initialize(options)
      super
      @cost = options[:cost]
    end

    def body
      "Deducted your gas cost of #{formatted_cost}. Your balance is now #{formatted_balance}. Please submit the receipt when you return the key."
    end

    private
    def formatted_cost
      format(@cost)
    end

    def formatted_balance
      format(@sharer.balance)
    end

    def format(number)
      ActionController::Base.helpers.number_to_currency(number)
    end
  end
end
