module Commands
  class Email < AbstractCommand
    def initialize(options)
      super
      @address = options[:address]
    end

    def execute
      sharer.email = @address
      sharer.save

      @responses.push Responses::Email.new(car: car, sharer: sharer)
    end
  end
end
