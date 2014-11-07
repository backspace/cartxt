module Responses
  class CommandsAdmin < DynamicResponse
    def self.default_body
      <<-TXT.strip_heredoc
        Admin commands:

        approve, reject
        collect
      TXT
    end
  end
end
