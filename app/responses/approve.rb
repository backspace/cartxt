module Responses
  class Approve < DynamicResponse
    description "Tells a new sharer they are approved to share the car."

    default_body "You are now approved to share the car. You can use commands like \"book\", \"borrow\", and \"status\". For a list of commands say \"commands\" and for help on a specific command like \"book\", say \"commands book\"."

    def initialize(options)
      @from = options[:car]
      @to = options[:approvee]
    end
  end
end
