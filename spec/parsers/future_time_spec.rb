describe Parsers::FutureTime do
  before do
    Timecop.freeze(Time.local(2014, 11, 14, 14, 25, 0))
  end

  after do
    Timecop.return
  end

  def parse(time_string)
    Parsers::FutureTime.new(time_string).parse.to_formatted_s
  end

  it "assumes today for a dateless time after now" do
    expect(parse("3pm")).to eq("2014-11-14  3:00PM")
  end

  it "assumes tomorrow for a dateless time before now" do
    expect(parse("1pm")).to eq("2014-11-15  1:00PM")
  end

  it "parses a relative date" do
    expect(parse("next wednesday at 10am")).to eq("2014-11-19 10:00AM")
  end

  it "parses an exact time" do
    expect(parse("2014-12-01 8:30am")).to eq("2014-12-01  8:30AM")
  end
end
