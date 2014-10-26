describe Commands::Parser do
  let(:txt) { Txt.new(from: :from, to: :to, body: body) }

  def parsed_command
    Commands::Parser.new(txt).parse
  end

  context 'when the command is a status request' do
    let(:body) { 'status' }

    it 'it returns a Status command' do
      status_double = double
      expect(Commands::Status).to receive(:new).with(car: Car.first, sharer: Sharer.new(number: :from)).and_return status_double

      expect(parsed_command).to be(status_double)
    end
  end

  context 'when the command is an odometer report' do
    let(:body) { '555' }

    it 'returns an OdometerReport command' do
      report_double = double
      expect(Commands::OdometerReport).to receive(:new).with(car: Car.first, sharer: Sharer.new(number: :from), reading: body).and_return report_double
      expect(parsed_command).to be(report_double)
    end
  end
end
