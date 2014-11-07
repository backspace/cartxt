module Responses
  class CommandsBook < DynamicResponse
    description "Describers how to use the book command."

    default_body "book: lets you book the car in the future. For now, it is brittle and requests must be of this form: \"book from YYYY-MM-DD HH:MM to YYYY-MM-DD HH:MM\"."
  end
end
