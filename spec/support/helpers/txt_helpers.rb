module Features
  module TxtHelpers
    def send_txt(body)
      post '/txts', From: 'Driver', To: 'Bot', Body: body
    end
  end
end
