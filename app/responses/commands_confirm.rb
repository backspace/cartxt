module Responses
  class CommandsConfirm < DynamicResponse
    description "Describes how to use the confirm command."

    default_body "confirm: when you have issued a \"book\" command, use \"confirm\" to confirm that the booking start and end were correctly interpreted."
  end
end
