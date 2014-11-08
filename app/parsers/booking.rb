module Parsers
  class Booking
    def initialize(string)
      @string = string
    end

    def parse
      return parse_on_date_from_time_to_time if matches?(ON_DATE_FROM_TIME_TO_TIME)
      return parse_from_datetime_to_datetime if matches?(FROM_DATETIME_TO_DATETIME)
    end

    private
    ON_DATE_FROM_TIME_TO_TIME = /on (.*) from (.*) to (.*)/
    FROM_DATETIME_TO_DATETIME = /from (.*) to (.*)/

    def matches?(regex)
      @string =~ regex
    end

    def parse_from_datetime_to_datetime
      begins_at_string, ends_at_string = @string.strip.split("from ").join("").split(" to ")

      begins_at = Time.zone.parse(begins_at_string)
      ends_at = Time.zone.parse(ends_at_string)

      OpenStruct.new(begins_at: begins_at, ends_at: ends_at)
    end

    def parse_on_date_from_time_to_time
      @string =~ ON_DATE_FROM_TIME_TO_TIME
      begins_at = Time.zone.parse("#{$1} #{$2}")
      ends_at = Time.zone.parse("#{$1} #{$3}")

      OpenStruct.new(begins_at: begins_at, ends_at: ends_at)
    end
  end
end
