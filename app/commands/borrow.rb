module Commands
  class Borrow < AbstractCommand
    def initialize(options)
      super
    end

    def execute
      @car.status = 'borrowed'
      @car.save

      @responses.push Response.new(from: @car, to: @sharer, body: "The car is yours!")
    end
  end
end
