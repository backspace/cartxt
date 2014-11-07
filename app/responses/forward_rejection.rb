module Responses
  class ForwardRejection < DynamicResponse
    description "Sent to admins when a sharer who has been rejected sends a message."

    expose :rejected_sharer, presenter: "Sharer"
    expose :rejected_txt

    default_body "Rejected sharer {{rejected_sharer.formatted}} sent this and I ignored it: {{rejected_txt}}"

    def initialize(options)
      super

      @from = options[:car]
      @to = options[:admin]
    end
  end
end
