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
      elsif sharer.admin? && command == 'approve'
        Approve.new(car: car, sharer: sharer, unapproved_sharer_number: command_parameters)
      elsif sharer.admin? && command == 'reject'
        Reject.new(car: car, sharer: sharer, unapproved_sharer_number: command_parameters)
      elsif command == 'status'
        Status.new(car: car, sharer: sharer)
      elsif command == 'borrow'
        Borrow.new(car: car, sharer: sharer)
      elsif command == 'return'
        Return.new(car: car, sharer: sharer)
      elsif command == 'balance'
        Balance.new(car: car, sharer: sharer)
      elsif command == 'join'
        Join.new(car: car, sharer: sharer)
      elsif command == 'book'
        Book.new(car: car, sharer: sharer, booking_string: command_parameters)
      elsif command == 'confirm'
        Confirm.new(car: car, sharer: sharer)
      elsif command == 'cancel'
        Cancel.new(car: car, sharer: sharer)
      elsif command == 'gas'
        Gas.new(car: car, sharer: sharer, cost_string: command_parameters)
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

    def command
      @txt.body.split.first.downcase
    end

    def command_parameters
      if @txt.body.include? " "
        @txt.body[@txt.body.index(" ") + 1..-1]
      else
        ""
      end
    end

  end
end
