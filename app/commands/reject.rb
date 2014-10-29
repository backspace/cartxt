module Commands
  class Reject < AbstractCommand
    def initialize(options)
      super

      @unapproved_sharer_number = options[:unapproved_sharer_number]
    end

    def execute
      unapproved_sharer = Sharer.find_by(status: 'unapproved', number: @unapproved_sharer_number)

      unapproved_sharer.reject!

      @responses.push Responses::Reject.new(car: car, admin: sharer, rejectee: unapproved_sharer)
    end
  end
end
