module Commands
  class Commands < AbstractCommand
    def execute
      @responses.push Responses::Commands.new(car: car, sharer: sharer)
      @responses.push Responses::CommandsAdmin.new(car: car, sharer: sharer) if sharer.admin?
    end
  end
end
