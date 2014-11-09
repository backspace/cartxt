module Responses
  class CommandsAbandon < DynamicResponse
    description "Describes how to use the abandon command."

    default_body "abandon: when you have issued a \"book\" command, use \"abandon\" to abandon it before confirming it."
  end
end
