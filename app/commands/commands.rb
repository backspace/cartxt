module Commands
  class Commands < AbstractCommand
    def initialize(options)
      super
      @command = options[:parameter]

      @recognised_commands = %w(
        balance
        book
        confirm
        cancel
        borrow
        return
        gas
        pay
        status
      )
    end

    def execute
      if @recognised_commands.include? @command
        @responses.push response_class
      else
        @responses.push Responses::Commands.new(car: car, sharer: sharer)
        @responses.push Responses::CommandsAdmin.new(car: car, sharer: sharer) if sharer.admin?
      end
    end

    private
    def command
      @command
    end

    def response_class
      "Responses::Commands#{command.titleize}".constantize.new(car: car, sharer: sharer)
    end
  end
end
