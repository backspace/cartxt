module Responses
  class ApproveAdmin < DynamicResponse
    description "Sent to an admin after they approve a new sharer."

    expose :approvee, presenter: "Sharer"

    default_body "I have welcomed {{approvee.name}} to share me."

    def initialize(options)
      super

      @from = options[:car]
      @to = options[:admin]
    end
  end
end
