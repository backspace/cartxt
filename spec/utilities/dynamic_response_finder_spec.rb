describe Utilities::DynamicResponseFinder do
  module Responses
    class Test < DynamicResponse
      def self.default_body
        "This is the default body."
      end
    end
  end

  context 'when the dynamic response is overridden' do
    let(:overridden_response) { "This is a dynamic body." }
    let(:response) { double(body: overridden_response) }

    before do
      expect(Response).to receive(:find_by).with(name: 'test').and_return(response)
    end

    it 'returns the response' do
      expect(Utilities::DynamicResponseFinder.new(Responses::Test).response).to eq(response)
    end
  end

  context 'when the dynamic response is not overridden' do
    let(:response) { double }

    before do
      expect(Response).to receive(:find_by).with(name: 'test').and_return(nil)
    end

    it 'returns a new response with the default body' do
      expect(Response).to receive(:new).with(name: 'test', body: Responses::Test.default_body).and_return(response)

      expect(Utilities::DynamicResponseFinder.new(Responses::Test).response).to eq(response)
    end
  end
end
