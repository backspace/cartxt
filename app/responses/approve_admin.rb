module Responses
  class ApproveAdmin < DynamicResponse
    description "Sent to an admin after they approve a new sharer."

    expose :approvee, presenter: "Sharer"

    default_body "Welcomed {{approvee.name}} to share the car."

    def initialize(options)
      super

      @from = options[:car]
      @to = options[:admin]
    end
  end
end
