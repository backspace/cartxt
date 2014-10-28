module Commands
  class Reject < AbstractCommand
    def initialize(options)
      super

      @unapproved_sharer_number = options[:unapproved_sharer_number]
    end

    def execute
      unapproved_sharer = Sharer.find_by(status: 'unapproved', number: @unapproved_sharer_number)

      unapproved_sharer.reject!

      @responses.push Response.new(from: car, to: sharer, body: "We silently rejected #{unapproved_sharer.name}, at number #{unapproved_sharer.number}.")
    end
  end
end
