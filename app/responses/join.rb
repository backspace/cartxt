module Responses
  class Join < DynamicResponse
    default_body "Hello there! {{car.description | with_conditional_following_space }}To join in sharing me, please reply with your name."
  end
end
