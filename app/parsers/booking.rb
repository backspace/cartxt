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
    ON_DATE_FROM_TIME_TO_TIME = /(on )?(.*) from (.*) to (.*)/
    FROM_DATETIME_TO_DATETIME = /from (.*) to (.*)/

    def matches?(regex)
      @string =~ regex
    end

    def parse_from_datetime_to_datetime
      @string =~ FROM_DATETIME_TO_DATETIME

      begins_at = Chronic.parse("#{$1}")
      ends_at = Chronic.parse("#{$2}")

      OpenStruct.new(begins_at: begins_at, ends_at: ends_at)
    end

    def parse_on_date_from_time_to_time
      @string =~ ON_DATE_FROM_TIME_TO_TIME
      begins_at = Chronic.parse("#{$2} #{$3}")
      ends_at = Chronic.parse("#{$2} #{$4}")

      OpenStruct.new(begins_at: begins_at, ends_at: ends_at)
    end
  end
end
