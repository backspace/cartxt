module Responses
  class Join < DynamicResponse
    description "Sent when a sharer wants to join the share."

    default_body "Hello there! {{car.description | with_conditional_following_space }}To join in sharing me, please reply with your name."
  end
end
