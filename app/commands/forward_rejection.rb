module Commands
  class ForwardRejection < AbstractCommand
    def initialize(options)
      super

      @txt = options[:txt]
    end

    def execute
      Sharer.admin.each do |admin|
        @responses.push Responses::ForwardRejection.new(car: car, admin: admin, rejected_sharer: sharer, rejected_txt: @txt)
      end
    end
  end
end
