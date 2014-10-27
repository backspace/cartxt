module Commands
  class Parser
    def initialize(txt)
      @txt = txt
    end

    def parse
      if @txt.body == 'status'
        Status.new(car: car, sharer: Sharer.new(number: @txt.from))
      elsif @txt.body == 'borrow'
        Borrow.new(car: car, sharer: Sharer.new(number: @txt.from))
      elsif @txt.body == 'return'
        Return.new(car: car, sharer: Sharer.new(number: @txt.from))
      else
        OdometerReport.new(car: car, sharer: Sharer.new(number: @txt.from), reading: @txt.body)
      end
    end

    private
    def car
      Car.find_by(number: @txt.to)
    end
  end
end
