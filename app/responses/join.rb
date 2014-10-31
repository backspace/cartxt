module Responses
  class Join < AbstractResponse
    def body
      "Hello there! #{afterspace_potential_content(@car.description)}To join in sharing me, please reply with your name."
    end
  end
end
