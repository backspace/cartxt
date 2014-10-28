module Commands
  class Parser
    def initialize(txt)
      @txt = txt
    end

    def parse
      if sharer.rejected?
        ForwardRejection.new(car: car, sharer: sharer, txt: @txt.body)
      elsif sharer.unnamed?
        Name.new(car: car, sharer: sharer, name: @txt.body)
      elsif sharer.admin? && @txt.body.starts_with?('approve')
        Approve.new(car: car, sharer: sharer, unapproved_sharer_number: @txt.body.split[1..-1].join(" "))
      elsif sharer.admin? && @txt.body.starts_with?('reject')
        Reject.new(car: car, sharer: sharer, unapproved_sharer_number: @txt.body.split[1..-1].join(" "))
      elsif @txt.body == 'status'
        Status.new(car: car, sharer: sharer)
      elsif @txt.body == 'borrow'
        Borrow.new(car: car, sharer: sharer)
      elsif @txt.body == 'return'
        Return.new(car: car, sharer: sharer)
      elsif @txt.body == 'join'
        Join.new(car: car, sharer: sharer)
      else
        OdometerReport.new(car: car, sharer: sharer, reading: @txt.body)
      end
    end

    private
    def car
      Car.find_by(number: @txt.to)
    end

    def sharer
      Sharer.find_by(number: @txt.from) || Sharer.new(number: @txt.from)
    end
  end
end
