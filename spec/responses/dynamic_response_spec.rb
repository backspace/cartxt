describe Responses::DynamicResponse do
  let(:default_body) { "This is the default body." }

  let(:sharer) { double(name: :name) }

  module Responses
    class Test < DynamicResponse
      def default_body
        "This is the default body."
      end
    end
  end

  def response
    Responses::Test.new(sharer: sharer).body
  end

  context 'when the dynamic response is not overridden' do
    before do
      expect(Response).to receive(:find_by).with(name: 'test').and_return(nil)
    end

    it 'returns the rendered default body' do
      expect(Liquid::Template).to receive(:parse).with(default_body).and_return(template = double)
      expect(template).to receive(:render).with('sender_name' => sharer.name).and_return(rendered = :rendered)
      expect(response).to eq(rendered)
    end
  end

  context 'when the dynamic response is overridden' do
    let(:overridden_response) { "This is a dynamic body." }

    before do
      expect(Response).to receive(:find_by).with(name: 'test').and_return(double(body: overridden_response))
    end

    it 'returns the rendered body' do
      expect(Liquid::Template).to receive(:parse).with(overridden_response).and_return(template = double)
      expect(template).to receive(:render).with('sender_name' => sharer.name).and_return(rendered = :rendered)
      expect(response).to eq(rendered)
    end
  end
end
