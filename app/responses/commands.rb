module Responses
  class Commands < DynamicResponse
    description "Lists the available commands."

    default_body <<-TXT.strip_heredoc
      Available commands:

      balance
      book, confirm, abandon
      borrow, return

      gas

      pay

      status


      For help on a specific command, say:
      \"commands commandname\"
    TXT
  end
end
