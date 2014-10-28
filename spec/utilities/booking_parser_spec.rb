describe Utilities::BookingParser do
  let(:examples) do
    {
      'from 2014-01-01 9:00am to 2014-01-01 10am' => ["2014-01-01  9:00AM", "2014-01-01 10:00AM"]
    }
  end

  def format_time(time)
    time.strftime("%Y-%m-%d %l:%M%p")
  end

  it 'parses bookings' do
    examples.each do |string, date_strings|
      dates = Utilities::BookingParser.new(string).parse

      expect(date_strings.first).to eq(format_time(dates.begins_at))
      expect(date_strings.last).to eq(format_time(dates.ends_at))
    end
  end
end
