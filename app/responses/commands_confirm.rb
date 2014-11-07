module Responses
  class CommandsConfirm < DynamicResponse
    def self.default_body
      "confirm: when you have issued a \"book\" command, use \"confirm\" to confirm that the booking start and end were correctly interpreted."
    end
  end
end
