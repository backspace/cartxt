module Responses
  class Reject < DynamicResponse
    description "Sent when an admin rejects a new sharer."

    expose :rejectee, presenter: "Sharer"

    default_body "I silently rejected {{rejectee.formatted}}."

    def initialize(options)
      super
      @to = options[:admin]
    end
  end
end
