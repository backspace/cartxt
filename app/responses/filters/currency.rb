module Responses
  module Filters
    module Currency
      def as_currency(input)
        ActionController::Base.helpers.number_to_currency(input)
      end
    end
  end
end
