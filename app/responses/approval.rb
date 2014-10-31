module Responses
  class Approval < AbstractResponse
    def initialize(options)
      @from = options[:car]
      @to = options[:approvee]
    end

    def body
      "You are now approved to share me."
    end
  end
end
