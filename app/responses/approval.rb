module Responses
  class Approval < AbstractResponse
    def initialize(options)
      @from = options[:car]
      @to = options[:approvee]
    end

    def body
      "You were approved by an admin! Welcome to the car share."
    end
  end
end
