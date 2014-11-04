module Responses
  module Filters
    module Spacing
      def with_conditional_following_space(input)
        input.present? ? "#{input} " : ""
      end
    end
  end
end
