module Features
  module TxtHelpers
    def send_txt(body)
      send_txt_from('Driver', body)
    end

    def send_txt_from(from, body)
      post '/txts', From: from, To: 'Bot', Body: body
    end

    def expect_txt_response(body)
      expect_txt_response_to 'Driver', body
    end

    def expect_txt_response_to(to, body)
      expect(GatewayRepository.gateway).to receive(:deliver).with(from: 'Bot', to: to, body: body)
    end
  end
end
