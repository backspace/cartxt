module Responses
  class CommandsBook < DynamicResponse
    description "Describers how to use the book command."

    default_body <<-TXT.strip_heredoc
      book: lets you book the car in the future. Examples:

      book tomorrow from 9am to 1pm
      book on friday from 5pm to 7pm
      book from monday at 5pm to tuesday at 10am

      The system will ask for your confirmation before making the booking. If you have trouble getting it to understand, try being very specific:

      book from 2014-11-08 5:00pm to 2014-11-09 10:00am
    TXT
  end
end
