describe Formatters::Booking do
  before do
    Timecop.freeze(Time.local(2014, 10, 31, 19, 17, 0))
  end

  after do
    Timecop.return
  end

  def format(from, to)
    booking = OpenStruct.new(
      begins_at: Time.zone.parse(from),
      ends_at: Time.zone.parse(to)
    )

    Formatters::Booking.new(booking).format
  end

  it 'uses full dates far in the future' do
    expect(format(
      "2015-06-01 8:00am",
      "2015-06-02 9:00am"
    )).to eq("from 2015-06-01 8:00AM to 2015-06-02 9:00AM")
  end

  it 'uses only one date when not spanning a day' do
    expect(format(
      "2015-06-01 8:00am",
      "2015-06-01 9:00pm",
    )).to eq("from 8:00AM to 9:00PM on 2015-06-01")
  end

  it "uses relative dates in the next month" do
    expect(format(
      "2014-11-09 16:55",
      "2014-11-09 19:00",
    )).to eq("from 4:55PM to 7:00PM on Sunday the 9th")
  end

  it "uses tomorrow for tomorrow" do
    expect(format(
      "2014-11-01 9:00am",
      "2014-11-01 10:00am"
    )).to eq("tomorrow from 9:00AM to 10:00AM")
  end

  it "uses today for today" do
    expect(format(
      "2014-10-31 9:30pm",
      "2014-10-31 10:30pm"
    )).to eq("today from 9:30PM to 10:30PM")
  end

  it "uses full dates in the past" do
    expect(format(
      "2014-10-31 9:00am",
      "2014-10-31 9:30am"
    )).to eq("from 2014-10-31 9:00AM to 2014-10-31 9:30AM")
  end
end
