module Parsers
  class Command
    def initialize(txt)
      @txt = txt
    end

    def parse
      if sharer.rejected?
        Commands::ForwardRejection.new(car: car, sharer: sharer, txt: @txt.body)
      elsif sharer.unnamed?
        Commands::Name.new(car: car, sharer: sharer, name: @txt.body)
      elsif sharer.admin? && command == 'approve'
        Commands::Approve.new(car: car, sharer: sharer, unapproved_sharer_number: command_parameters)
      elsif sharer.admin? && command == 'reject'
        Commands::Reject.new(car: car, sharer: sharer, unapproved_sharer_number: command_parameters)
      elsif sharer.admin? && command == 'collect'
        Commands::Collect.new(car: car, sharer: sharer, collection_string: command_parameters)
      elsif sharer.admin? && command == 'who'
        Commands::Who.new(car: car, sharer: sharer)
      elsif command == 'status'
        Commands::Status.new(car: car, sharer: sharer)
      elsif command == 'borrow'
        Commands::Borrow.new(car: car, sharer: sharer)
      elsif command == 'return'
        Commands::Return.new(car: car, sharer: sharer)
      elsif command == 'balance'
        Commands::Balance.new(car: car, sharer: sharer)
      elsif command == 'join'
        Commands::Join.new(car: car, sharer: sharer)
      elsif command == 'book'
        Commands::Book.new(car: car, sharer: sharer, booking_string: command_parameters)
      elsif command == 'confirm'
        Commands::Confirm.new(car: car, sharer: sharer)
      elsif command == 'abandon'
        Commands::Abandon.new(car: car, sharer: sharer)
      elsif command == 'gas'
        Commands::Gas.new(car: car, sharer: sharer, cost_string: command_parameters)
      elsif command == 'pay'
        Commands::Pay.new(car: car, sharer: sharer, amount_string: command_parameters)
      elsif command == "email"
        Commands::Email.new(car: car, sharer: sharer, address: command_parameters)
      elsif command == "bookings"
        Commands::Bookings.new(car: car, sharer: sharer)
      elsif command == 'commands'
        Commands::Commands.new(car: car, sharer: sharer, parameter: command_parameters)
      elsif command_is_integer?
        Commands::OdometerReport.new(car: car, sharer: sharer, reading: @txt.body)
      else
        Commands::Commands.new(car: car, sharer: sharer)
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

    def command_is_integer?
      command.to_i.to_s == command
    end
  end
end
