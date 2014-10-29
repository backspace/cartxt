module Responses
  class Balance < AbstractResponse
    def initialize(options)
      @from = options[:car]
      @to = options[:sharer]
    end

    def body
      "Your current balance is #{ActionController::Base.helpers.number_to_currency(@to.balance)}."
    end
  end
end
