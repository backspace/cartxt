module Commands
  class ForwardRejection < AbstractCommand
    def initialize(options)
      super

      @txt = options[:txt]
    end

    def execute
      Sharer.admin.each do |admin|
        @responses.push Response.new(from: car, to: admin, body: "Rejected sharer #{sharer.name} at number #{sharer.number} sent this and we ignored it: #{@txt}")
      end
    end
  end
end
