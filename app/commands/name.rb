module Commands
  class Name < AbstractCommand
    def initialize(options)
      super

      @new_name = options[:name]
    end

    def execute
      sharer.rename!(@new_name)

      @responses.push Responses::Name.new(car: car, sharer: sharer)

      Sharer.admin.each do |admin|
        @responses.push Responses::AdminApprovalRequest.new(car: car, sharer: sharer, admin: admin)
      end
    end
  end
end
