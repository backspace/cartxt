module Commands
  class Reject < AbstractCommand
    def initialize(options)
      super

      @unapproved_sharer_number = options[:unapproved_sharer_number]
    end

    def execute
      unapproved_sharer = Sharer.find_by(status: 'unapproved', number: @unapproved_sharer_number)

      unapproved_sharer.reject!

      append_response "I silently rejected #{unapproved_sharer.name}, at number #{unapproved_sharer.number}."
    end
  end
end
