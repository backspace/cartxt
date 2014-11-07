module Responses
  class CommandsCancel < DynamicResponse
    def self.default_body
      "cancel: when you have issued a \"book\" command, use \"cancel\" to cancel it before confirming it."
    end
  end
end
