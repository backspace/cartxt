module Responses
  class Cancel < DynamicResponse
    description "Sent when a sharer cancels a proposed booking."

    default_body "Okay, I canceled your booking request."

    def initialize(options)
      super
      @booking = options[:booking]
    end
  end
end
