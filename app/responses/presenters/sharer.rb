module Responses
  module Presenters
    class Sharer < Liquid::Drop
      delegate :name, :number, :balance, :pending_payments, :pending_balance, to: :@sharer

      def initialize(sharer)
        @sharer = sharer
      end

      def formatted
        Formatters::Sharer.new(@sharer).format
      end
    end
  end
end
