module Responses
  class Reject < DynamicResponse
    expose :rejectee, presenter: "Sharer"

    default_body "I silently rejected {{rejectee.formatted}}."

    def initialize(options)
      super
      @to = options[:admin]
    end
  end
end
