module Commands
  class Balance < AbstractCommand
    def execute
      @responses.push Response.new(from: car, to: sharer, body: "Your current balance is #{ActionController::Base.helpers.number_to_currency(sharer.balance)}.")
    end
  end
end
