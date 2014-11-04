module Responses
  class Cancel < DynamicResponse
    description "Sent when a sharer cancels a proposed booking."

    def initialize(options)
      super
      @booking = options[:booking]
    end

    def self.default_body
      "Okay, I canceled your booking request."
    end
  end
end
