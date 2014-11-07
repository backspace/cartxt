module Responses
  class CommandsCancel < DynamicResponse
    default_body "cancel: when you have issued a \"book\" command, use \"cancel\" to cancel it before confirming it."
  end
end
