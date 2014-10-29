module Commands
  class Approve < AbstractCommand
    def initialize(options)
      super

      @unapproved_sharer_number = options[:unapproved_sharer_number]
    end

    def execute
      unapproved_sharer = Sharer.find_by(status: 'unapproved', number: @unapproved_sharer_number)

      unapproved_sharer.approve!

      @responses.push Responses::ApprovalAdmin.new(car: car, admin: sharer, approvee: unapproved_sharer)
      @responses.push Responses::Approval.new(car: car, approvee: unapproved_sharer)
    end
  end
end
