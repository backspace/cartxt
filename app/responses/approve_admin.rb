module Responses
  class ApproveAdmin < DynamicResponse
    expose :approvee, presenter: "Sharer"

    default_body "I have welcomed {{approvee.name}} to share me."

    def initialize(options)
      super

      @from = options[:car]
      @to = options[:admin]
    end
  end
end
