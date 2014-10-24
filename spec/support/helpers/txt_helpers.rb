module Features
  module TxtHelpers
    def send_txt(body)
      post '/txts', From: 'Driver', To: 'Bot', Body: body
    end

    def expect_txt_response(body)
      expect(GatewayRepository.gateway).to receive(:deliver).with(from: 'Bot', to: 'Driver', body: body)
    end
  end
end
