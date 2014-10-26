module Commands
  class Parser
    def initialize(txt)
      @txt = txt
    end

    def parse
      if @txt.body == 'status'
        Status.new(car: Car.first, sharer: Sharer.new(number: @txt.from))
      else
        OdometerReport.new(car: Car.first, sharer: Sharer.new(number: @txt.from), reading: @txt.body)
      end
    end
  end
end
