module Responses
  class CommandsBook < DynamicResponse
    description "Describers how to use the book command."

    default_body <<-TXT.strip_heredoc
      book: lets you book the car in the future. Examples:

      book tomorrow from 9a to 1p
      book on friday from 5p to 7p
      book from monday at 5p to tuesday at 10a

      I will ask for your confirmation before making the booking. If you have trouble getting me to understand, it is easier for me if you are very specific:

      book from 2014-11-08 5:00pm to 2014-11-09 10:00am
    TXT
  end
end
