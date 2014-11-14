describe Formatters::RelativeTime do
  before do
    Timecop.freeze(Time.local(2014, 11, 14, 11, 24, 0))
  end

  after do
    Timecop.return
  end

  def format(time_string)
    Formatters::RelativeTime.new(Time.zone.parse(time_string)).format
  end

  it "uses today for today" do
    expect(format("2014-11-14 1:00pm")).to eq("today (Friday) at 1:00PM")
  end

  it "uses tomorrow for tomorrow" do
    expect(format("2014-11-15 10am")).to eq("tomorrow (Saturday) at 10:00AM")
  end

  it "uses a relative date for the near future" do
    expect(format("2014-11-19 5:00pm")).to eq("Wednesday the 19th at 5:00PM")
  end

  it "uses a relative date up to a month away" do
    expect(format("2014-12-13 10:00am")).to eq("Saturday the 13th at 10:00AM")
  end

  it "uses a full date over a month away" do
    expect(format("2014-12-15 7:00pm")).to eq("2014-12-15 7:00PM")
  end
end
