module Responses
  class Reject < AbstractResponse
    def initialize(options)
      super
      @to = options[:admin]
      @rejectee = options[:rejectee]
    end

    def body
      "I silently rejected #{@rejectee.name}, at number #{@rejectee.number}."
    end
  end
end
