module Responses
  class CommandsAdmin < DynamicResponse
    description "Lists admin-level commands."

    default_body <<-TXT.strip_heredoc
      Admin commands:

      approve, reject
      collect
    TXT
  end
end
