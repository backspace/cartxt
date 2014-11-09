module Commands
  class Who < AbstractCommand
    def execute
      @responses.push Responses::Who.new(car: car, sharer: sharer, sharers: Sharer.all)
    end
  end
end
