describe ProcessIncomingTxtService do
  let(:txt) { OpenStruct.new(from: :from, to: :to, body: 'abc') }

  before do
    GatewayRepository.gateway = double
  end

  it 'responds with an updated odometer' do
    expect(GatewayRepository.gateway).to receive(:deliver).with(from: :to, to: :from, body: "Set odometer reading to abc")
    ProcessIncomingTxtService.new(txt).process
  end
end
