module Responses
  class CommandsCancel < DynamicResponse
    description "Describes how to use the cancel command."

    default_body "cancel: when you have issued a \"book\" command, use \"cancel\" to cancel it before confirming it."
  end
end
