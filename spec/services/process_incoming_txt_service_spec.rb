describe ProcessIncomingTxtService do
  let(:txt) { Txt.new(from: :from, to: :to, body: :body) }
  let(:gateway) { double }

  it 'delegates to the parser and delivers the responses' do
    parser = double
    expect(Commands::Parser).to receive(:new).with(txt).and_return parser

    command = double
    expect(parser).to receive(:parse).and_return command
    expect(command).to receive(:execute)

    response = double(from: double(number: :from), to: double(number: :to), body: :body)
    responses = [response]
    expect(command).to receive(:responses).and_return responses

    expect(gateway).to receive(:deliver).with(from: :from, to: :to, body: :body)

    ProcessIncomingTxtService.new(txt, gateway).process
  end
end
