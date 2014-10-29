module Responses
  class ApprovalAdmin < AbstractResponse
    def initialize(options)
      @from = options[:car]
      @to = options[:admin]

      @approvee = options[:approvee]
    end

    def body
      "I have welcomed #{@approvee.name} to the car share."
    end
  end
end
