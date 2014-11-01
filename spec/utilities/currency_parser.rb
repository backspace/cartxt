describe Utilities::CurrencyParser do
  let(:examples) do
    {
      '$5.00' => 5.0,
      '5.51' => 5.51,
      '7' => 7.0
    }
  end

  it 'parses currency values' do
    examples.each do |string, value|
      result = Utilities::CurrencyParser.new(string).parse
      expect(result).to eq(value)
    end
  end
end

