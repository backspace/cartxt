describe Commands::UnknownSharer do
  let(:car) { :car }
  let(:sharer) { :sharer }

  it 'responds with the UnknownSharer response' do
    unknown_sharer = Commands::UnknownSharer.new(car: car, sharer: sharer)

    expect(Responses::UnknownSharer).to receive(:new).with(car: car, sharer: sharer).and_return(response = double)
    unknown_sharer.execute

    expect(unknown_sharer.responses).to include(response)
  end
end
