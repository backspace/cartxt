module Responses
  class Join < AbstractResponse
    def body
      "Hello there! #{@car.description.present? ? "#{@car.description} " : ""}To join in sharing me, please reply with your name."
    end
  end
end
