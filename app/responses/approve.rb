module Responses
  class Approve < DynamicResponse
    description "Sent after an admin approves a new car-sharer."

    default_body "You are now approved to share me. I understand commands like \"book\", \"borrow\", and \"status\". For a list of commands say \"commands\" and for help on a specific command like \"book\", say \"commands book\"."

    def initialize(options)
      @from = options[:car]
      @to = options[:approvee]
    end
  end
end
