module Responses
  class Approve < DynamicResponse
    description "Sent after an admin approves a new car-sharer."

    def initialize(options)
      @from = options[:car]
      @to = options[:approvee]
    end

    def self.default_body
      "You are now approved to share me."
    end
  end
end
