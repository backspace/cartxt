module Parsers
  class FutureTime
    def initialize(string)
      @string = string

      Chronic.time_class = Time.zone
    end

    def parse
      parsed = Chronic.parse string

      parsed += 1.day if parsed < Time.now

      parsed
    end

    private
    def string
      @string
    end
  end
end
