module Responses
  class UnknownSharer < DynamicResponse
    description "Sent to someone who has not yet joined when they send a non-join message."

    default_body "Please join the car share by sending \"join\"."
  end
end
