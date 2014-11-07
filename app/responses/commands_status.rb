module Responses
  class CommandsStatus < DynamicResponse
    def self.default_body
      "status: tells you whether the car is currently available."
    end
  end
end
