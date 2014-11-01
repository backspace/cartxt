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
end
