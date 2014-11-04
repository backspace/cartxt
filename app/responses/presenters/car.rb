module Responses
  module Presenters
    class Car < Liquid::Drop
      delegate :returned?, :location_information, to: :@car

      def initialize(car)
        @car = car
      end
    end
  end
end
