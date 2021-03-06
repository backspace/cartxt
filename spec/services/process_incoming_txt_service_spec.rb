describe ProcessIncomingTxtService do
  let(:txt) { Txt.new(from: :from, to: :to, body: :body) }
  let(:gateway) { double }
  let(:context) { double }

  it 'delegates to the parser and delivers the responses' do
    expect(gateway).to receive(:deliver_original_copies).with(txt)

    parser = double
    expect(Parsers::Command).to receive(:new).with(txt, context).and_return parser

    command = double
    expect(parser).to receive(:parse).and_return command
    expect(command).to receive(:execute)

    response = double(from: double(number: :from), to: double(number: :to), body: :body)
    responses = [response]
    expect(command).to receive(:responses).and_return responses

    expect(gateway).to receive(:deliver).with(from: :from, to: :to, body: :body)
    expect(Txt).to receive(:new).with(from: :from, to: :to, body: :body, originator: txt).and_return(outgoing_txt = double(from: :from, to: :to, body: :body))
    expect(outgoing_txt).to receive(:save)

    ProcessIncomingTxtService.new(txt, gateway, context).process
  end
end
