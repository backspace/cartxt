RSpec::Matchers.define :have_responses_from_car_to do |sharer_to_body|
  match do |command|
    expect(command.responses.length).to eq(sharer_to_body.length)

    sharer_to_body.each do |sharer, body|
      expect(command.responses.map(&:to)).to include(sharer)

      response = command.responses.detect{|response| response.to == sharer}
      expect(response.from).to eq(command.car)
      expect(response.body).to eq(body)
    end
  end
end
