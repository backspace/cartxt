describe Responses::DynamicResponse do
  let(:default_body) { "This is the default body." }

  let(:sharer) { double(name: :name) }
  let(:car) { double(:car) }
  let(:an_integer) { 30 }
  let(:test_object) { double(:test_object) }
  let(:a_string) { "string" }

  module Responses
    module Presenters
      class Test
        def initialize(object)
        end
      end
    end

    class Test < DynamicResponse
      expose :an_integer
      expose :test_object, class: Responses::Presenters::Test
      expose :a_string, input_name: :differently_named_string

      def self.default_body
        "This is the default body."
      end
    end
  end

  def response_body
    Responses::Test.new(sharer: sharer, car: car, an_integer: an_integer, test_object: test_object, differently_named_string: a_string).body
  end

  it 'returns the rendered body' do
    expect(Utilities::DynamicResponseFinder).to receive(:new).with(Responses::Test).and_return finder = double
    expect(finder).to receive(:response).and_return response = double(body: body = double)
    expect(Liquid::Template).to receive(:parse).with(body).and_return(template = double)

    expect(Responses::Presenters::Sharer).to receive(:new).with(sharer).and_return sender_presenter = double
    expect(Responses::Presenters::Car).to receive(:new).with(car).and_return car_presenter = double
    expect(Responses::Presenters::Test).to receive(:new).with(test_object).and_return test_object_presenter = double

    expect(template).to receive(:render).with({'sender' => sender_presenter, 'car' => car_presenter, 'an_integer' => an_integer, 'test_object' => test_object_presenter, 'a_string' => a_string}, filters: [Responses::Filters::Currency]).and_return(rendered = :rendered)
    expect(response_body).to eq(rendered)
  end
end
