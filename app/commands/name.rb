module Commands
  class Name < AbstractCommand
    def initialize(options)
      super

      @new_name = options[:name]
    end

    def execute
      sharer.rename!(@new_name)

      append_response "Nice to meet you, #{@new_name}. Please await admin approval."

      Sharer.admin.each do |admin|
        append_response_to admin, "#{@new_name}, from number #{sharer.number}, would like to join. Reply with \"approve #{sharer.number}\" (or reject)."
      end
    end
  end
end
