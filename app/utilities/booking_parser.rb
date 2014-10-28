module Utilities
  class BookingParser
    def initialize(string)
      @string = string
    end

    def parse
      begins_at_string, ends_at_string = @string.strip.split("from ").join("").split(" to ")

      begins_at = Time.zone.parse(begins_at_string)
      ends_at = Time.zone.parse(ends_at_string)

      OpenStruct.new(begins_at: begins_at, ends_at: ends_at)
    end
  end
end
