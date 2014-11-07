module Responses
  class CommandsBorrow < DynamicResponse
    description "Describers how to use the borrow command."

    default_body "borrow: start the process of borrowing the car right now."
  end
end
