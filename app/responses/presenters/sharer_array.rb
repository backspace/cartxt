module Responses
  module Presenters
    class SharerArray < SimpleDelegator
      def initialize(sharers)
        super(sharers.map{|sharer| Responses::Presenters::Sharer.new(sharer)})
      end
    end
  end
end
