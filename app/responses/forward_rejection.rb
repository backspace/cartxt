module Responses
  class ForwardRejection < DynamicResponse
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
