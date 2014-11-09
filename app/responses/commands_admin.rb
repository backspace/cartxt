module Responses
  class CommandsAdmin < DynamicResponse
    description "Lists admin-level commands."

    default_body <<-TXT.strip_heredoc
      Admin commands:

      approve, reject
      collect
      who
    TXT
  end
end
