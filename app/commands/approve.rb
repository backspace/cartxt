module Commands
  class Approve < AbstractCommand
    def initialize(options)
      super

      @unapproved_sharer_number = options[:unapproved_sharer_number]
    end

    def execute
      unapproved_sharer = Sharer.find_by(status: 'unapproved', number: @unapproved_sharer_number)

      unapproved_sharer.approve!

      @responses.push Response.new(from: car, to: sharer, body: "We have welcomed #{unapproved_sharer.name} to the car share.")
      @responses.push Response.new(from: car, to: unapproved_sharer, body: "You were approved by an admin! Welcome to the car share.")
    end
  end
end
