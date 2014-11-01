module Responses
  class ForwardRejection < AbstractResponse
    def initialize(options)
      @from = options[:car]
      @to = options[:admin]
      @rejected_sharer = options[:rejected_sharer]
      @rejected_txt = options[:rejected_txt]
    end

    def body
      "Rejected sharer #{Formatters::Sharer.new(@rejected_sharer).format} sent this and I ignored it: #{@rejected_txt}"
    end
  end
end
