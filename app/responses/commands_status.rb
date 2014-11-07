module Responses
  class CommandsStatus < DynamicResponse
    description "Describers how to use the status command."

    default_body "status: tells you whether the car is currently available."
  end
end
