describe Commands::Until, :command do
  let(:car) { double :car }
  let(:sharer) { double :sharer }

  let(:until_string) { :until_string }

  let(:additional_parameters) { {until_string: until_string} }

  let(:ends_at) { double(:ends_at) }

  let(:booking) { double(:booking) }

  before do
    Timecop.freeze

    expect(Parsers::FutureTime).to receive(:new).with(until_string).and_return double(:future_time_parser, parse: ends_at)

    expect(Booking).to receive(:new).with(begins_at: Time.now, ends_at: ends_at, car: car, sharer: sharer).and_return booking
  end

  after do
    Timecop.return
  end

  context "when the booking is valid" do
    before do
      expect(Validators::Booking).to receive(:new).with(car: car, booking: booking, exception: :past).and_return double(:validator, valid?: true)
    end

    it "saves the booking and delegates to the Borrow command" do
      expect(booking).to receive(:confirm)
      expect(booking).to receive(:save)

      expect(Commands::Borrow).to receive(:new).with(car: car, sharer: sharer).and_return borrow = double
      expect(borrow).to receive(:execute)
      expect(borrow).to receive(:responses).and_return delegate_responses = double

      expect(responses).to eq(delegate_responses)
    end
  end

  context "when the booking is invalid" do
    before do
      expect(Validators::Booking).to receive(:new).with(car: car, booking: booking, exception: :past).and_return @validator = double(:validator, valid?: false)
    end

    it "delegates to the BookFailure generator" do
      expect(Responses::Generators::BookFailure).to receive(:new).with(car: car, sharer: sharer, validator: @validator).and_return double(:generator, responses: generated_responses = double)
      expect(responses).to eq(generated_responses)
    end
  end
end
