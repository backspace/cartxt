describe Responses::DynamicResponse do
  let(:default_body) { "This is the default body." }
  module Responses
    class Test < DynamicResponse
      def default_body
        "This is the default body."
      end
    end
  end

  def response
    Responses::Test.new({}).body
  end

  context 'when the dynamic response is not overridden' do
    before do
      expect(Response).to receive(:find_by).with(name: 'test').and_return(nil)
    end

    it 'returns the default body' do
      expect(response).to eq(default_body)
    end
  end

  context 'when the dynamic response is overridden' do
    let(:overridden_response) { "This is a dynamic body." }

    before do
      expect(Response).to receive(:find_by).with(name: 'test').and_return(double(body: overridden_response))
    end

    it 'returns the overridden body' do
      expect(response).to eq(overridden_response)
    end
  end
end
