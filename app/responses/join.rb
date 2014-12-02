module Responses
  class Join < DynamicResponse
    description "Sent when a sharer wants to join the share."

    default_body "{{car.description | with_conditional_following_space }}To join in sharing the car, please reply with your name."
  end
end
