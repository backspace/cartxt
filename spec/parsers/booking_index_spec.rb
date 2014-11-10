describe Parsers::BookingIndex do
  let(:examples) do
    {
      "#5" => 4,
      "" => nil,
      "4" => 3,
    }
  end

  it "parses booking indices" do
    examples.each do |string, value|
      result = Parsers::BookingIndex.new(string).parse
      expect(result).to eq(value)
    end
  end
end
