module Responses
  module Generators
    class BookFailure
      def initialize(options)
        @car = options[:car]
        @sharer = options[:sharer]
        @validator = options[:validator]
      end

      def responses
        [Responses::BookFailure.new(car: @car, sharer: @sharer, conflicting_booking: @validator.conflicting_booking)]
      end
    end
  end
end
