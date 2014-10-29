module Responses
  class AdminApprovalRequest < AbstractResponse
    def initialize(options)
      super

      @to = options[:admin]
      @prospective_approvee = options[:sharer]
    end

    def body
      "#{@prospective_approvee.name}, from number #{@prospective_approvee.number}, would like to join. Reply with \"approve #{@prospective_approvee.number}\" (or reject)."
    end
  end
end
