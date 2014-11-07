module Responses
  class Approve < DynamicResponse
    description "Sent after an admin approves a new car-sharer."

    def initialize(options)
      @from = options[:car]
      @to = options[:approvee]
    end

    def self.default_body
      "You are now approved to share me. I understand commands like \"book\", \"borrow\", and \"status\". For a list of commands say \"commands\" and for help on a specific command like \"book\", say \"commands book\"."
    end
  end
end
