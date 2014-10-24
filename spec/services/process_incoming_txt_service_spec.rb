describe ProcessIncomingTxtService do
  let(:txt) { OpenStruct.new(from: :from, to: :to, body: body) }

  before do
    GatewayRepository.gateway = double
  end

  context 'with an odometer update' do
    let(:body) { 'abc' }

    it 'responds with an updated odometer' do
      expect(GatewayRepository.gateway).to receive(:deliver).with(from: :to, to: :from, body: "Set odometer reading to abc")
      ProcessIncomingTxtService.new(txt).process
    end
  end

  context 'with a status request' do
    let(:reading) { 200 }

    before do
      car = Car.create(odometer_reading: reading)
    end

    let(:body) { 'status' }

    it 'responds with the status' do
      expect(GatewayRepository.gateway).to receive(:deliver).with(from: :to, to: :from, body: "The odometer reading is #{reading}")
    end
  end
end
