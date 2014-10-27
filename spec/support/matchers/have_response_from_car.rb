RSpec::Matchers.define :have_response_from_car do |body|
  match do |command|
    expect(command.responses.length).to eq(1)

    response = command.responses.first
    expect(response.from).to eq(command.car)
    expect(response.to).to eq(command.sharer)
    expect(response.body).to eq(body)
  end
end
