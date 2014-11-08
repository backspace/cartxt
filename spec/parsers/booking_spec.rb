describe Parsers::Booking do
  let(:examples) do
    {
      'from 2014-01-01 9:00am to 2014-01-01 10am' => ["2014-01-01  9:00AM", "2014-01-01 10:00AM"],
      "on 2014-01-01 from 1:30pm to 5:00pm" => ["2014-01-01  1:30PM", "2014-01-01  5:00PM"]
    }
  end

  it 'parses bookings' do
    examples.each do |string, date_strings|
      dates = Parsers::Booking.new(string).parse

      expect(dates.begins_at.to_formatted_s).to eq(date_strings.first)
      expect(dates.ends_at.to_formatted_s).to eq(date_strings.last)
    end
  end
end
