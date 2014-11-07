module Responses
  class CommandsAdmin < DynamicResponse
    default_body <<-TXT.strip_heredoc
      Admin commands:

      approve, reject
      collect
    TXT
  end
end
