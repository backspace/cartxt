module Responses
  module Presenters
    class Car < Liquid::Drop
      delegate :returned?, to: :@car

      def initialize(car)
        @car = car
      end
    end
  end
end
