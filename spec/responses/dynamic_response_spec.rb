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

  def response_body
    Responses::Test.new(sharer: sharer).body
  end

  it 'returns the rendered body' do
    expect(Utilities::DynamicResponseFinder).to receive(:new).with(Responses::Test).and_return finder = double
    expect(finder).to receive(:response).and_return response = double(body: body = double)
    expect(Liquid::Template).to receive(:parse).with(body).and_return(template = double)
    expect(template).to receive(:render).with('sender_name' => sharer.name).and_return(rendered = :rendered)
    expect(response_body).to eq(rendered)
  end
end
