module Responses
  class ApproveAdminRequest < DynamicResponse
    expose :prospective_approvee, presenter: "Sharer", input_name: :sharer

    default_body "{{prospective_approvee.name}}, from number {{prospective_approvee.number}}, would like to join. Reply with \"approve {{prospective_approvee.number}}\" (or reject)."

    def initialize(options)
      super
      @to = options[:admin]
    end
  end
end
