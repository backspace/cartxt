module Responses
  class ForwardRejection < DynamicResponse
    expose :rejected_sharer, class: Presenters::Sharer
    expose :rejected_txt

    def initialize(options)
      super

      @from = options[:car]
      @to = options[:admin]
    end

    def self.default_body
      "Rejected sharer {{rejected_sharer.formatted}} sent this and I ignored it: {{rejected_txt}}"
    end
  end
end
