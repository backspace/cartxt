module Commands
  class Name < AbstractCommand
    def initialize(options)
      super

      @new_name = options[:name]
    end

    def execute
      sharer.rename!(@new_name)

      @responses.push Response.new(from: car, to: sharer, body: "Nice to meet you, #{@new_name}. Please await admin approval.")

      Sharer.admin.each do |admin|
        @responses.push Response.new(from: car, to: admin, body: "#{@new_name}, from number #{sharer.number}, would like to join. Reply with \"approve #{sharer.number}\" (or reject).")
      end
    end
  end
end
