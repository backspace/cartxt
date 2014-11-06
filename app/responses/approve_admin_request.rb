module Responses
  class ApproveAdminRequest < DynamicResponse
    expose :prospective_approvee, class: Responses::Presenters::Sharer, input_name: :sharer

    def initialize(options)
      super
      @to = options[:admin]
    end

    def self.default_body
      "{{prospective_approvee.name}}, from number {{prospective_approvee.number}}, would like to join. Reply with \"approve {{prospective_approvee.number}}\" (or reject)."
    end
  end
end
