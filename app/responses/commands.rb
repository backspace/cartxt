module Responses
  class Commands < DynamicResponse
    description "Lists the available commands."

    default_body <<-TXT.strip_heredoc
      Available commands:

      book, confirm, abandon, bookings
      borrow, return
      status

      gas, pay, balance

      email


      For help on a specific command, say:
      \"commands commandname\"
    TXT
  end
end
