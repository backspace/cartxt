module Responses
  class CommandsAbandon < DynamicResponse
    description "Describes how to use the abandon command."

    default_body "abandon: when you have issued a \"book\" command, use \"abandon\" to abandon it before confirming it. When it is confirmed, you can abandon it by number as listed by the \"bookings\" command with \"abandon #1\"."
  end
end
