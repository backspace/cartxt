module Responses
  class Reject < DynamicResponse
    expose :rejectee, presenter: "Sharer"

    def initialize(options)
      super
      @to = options[:admin]
    end

    def self.default_body
      "I silently rejected {{rejectee.formatted}}."
    end
  end
end
