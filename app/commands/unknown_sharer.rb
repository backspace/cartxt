module Commands
  class UnknownSharer < AbstractCommand
    def execute
      @responses.push Responses::UnknownSharer.new(car: car, sharer: sharer)
    end
  end
end
