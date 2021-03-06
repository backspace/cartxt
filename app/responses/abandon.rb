module Responses
  class Abandon < DynamicResponse
    description "Sent when a sharer abandons a proposed booking."

    default_body "Abandoned your booking request."

    def initialize(options)
      super
      @booking = options[:booking]
    end
  end
end
