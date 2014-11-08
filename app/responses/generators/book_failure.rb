module Responses
  module Generators
    class BookFailure
      def initialize(options)
        @car = options[:car]
        @sharer = options[:sharer]
        @validator = options[:validator]
      end

      def responses
        if @validator.conflict?
          [Responses::BookFailure.new(car: @car, sharer: @sharer, conflicting_booking: @validator.conflicting_booking)]
        elsif @validator.past?
          [Responses::BookPastFailure.new(car: @car, sharer: @sharer, booking: @validator.booking)]
        elsif @validator.reversed?
          [Responses::BookReversedFailure.new(car: @car, sharer: @sharer, booking: @validator.booking)]
        end
      end
    end
  end
end
