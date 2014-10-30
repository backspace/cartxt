module Responses
  class Cancel < AbstractResponse
    def initialize(options)
      super
      @booking = options[:booking]
    end

    def body
      "Okay, I canceled your booking request."
    end
  end
end
