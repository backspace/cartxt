module Responses
  class CommandsReturn < DynamicResponse
    def self.default_body
      "return: after you are done with the car, say \"return\" to start the process of returning it."
    end
  end
end
