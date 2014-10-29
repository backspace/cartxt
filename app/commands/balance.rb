module Commands
  class Balance < AbstractCommand
    def execute
      append_response "Your current balance is #{ActionController::Base.helpers.number_to_currency(sharer.balance)}."
    end
  end
end
