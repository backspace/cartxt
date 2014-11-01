module Responses
  class Reject < AbstractResponse
    def initialize(options)
      super
      @to = options[:admin]
      @rejectee = options[:rejectee]
    end

    def body
      "I silently rejected #{Formatters::Sharer.new(@rejectee).format}."
    end
  end
end
