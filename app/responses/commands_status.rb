module Responses
  class CommandsStatus < DynamicResponse
    default_body "status: tells you whether the car is currently available."
  end
end
