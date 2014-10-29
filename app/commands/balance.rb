module Commands
  class Balance < AbstractCommand
    def execute
      @responses.push Responses::Balance.new(car: car, sharer: sharer)
    end
  end
end
