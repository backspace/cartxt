module Responses
  module Presenters
    class Sharer < Liquid::Drop
      delegate :name, :number, :balance, to: :@sharer

      def initialize(sharer)
        @sharer = sharer
      end
    end
  end
end
