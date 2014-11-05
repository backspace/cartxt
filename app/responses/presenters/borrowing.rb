module Responses
  module Presenters
    class Borrowing < Liquid::Drop
      delegate :span, to: :@borrowing

      def initialize(borrowing)
        @borrowing = borrowing
      end
    end
  end
end
