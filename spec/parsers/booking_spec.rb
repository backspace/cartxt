describe Parsers::Booking do
  before do
    Timecop.freeze(Time.local(2014, 11, 8, 17, 11, 0))
  end

  after do
    Timecop.return
  end

  let(:examples) do
    {
      'from 2014-01-01 9:00am to 2014-01-01 10am' => ["2014-01-01  9:00AM", "2014-01-01 10:00AM"],
      "on 2014-01-01 from 1:30pm to 5:00pm" => ["2014-01-01  1:30PM", "2014-01-01  5:00PM"],
      "tomorrow from 8:00am to 9:00pm" => ["2014-11-09  8:00AM", "2014-11-09  9:00PM"],
      "from monday at 9pm to tuesday at 10am" => ["2014-11-10  9:00PM", "2014-11-11 10:00AM"],
      "friday from 8am to 10am" => ["2014-11-14  8:00AM", "2014-11-14 10:00AM"]
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
