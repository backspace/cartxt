module Responses
  class CommandsReturn < DynamicResponse
    description "Describes how to use the return command."

    default_body "return: after you are done with the car, say \"return\" to start the process of returning it."
  end
end
