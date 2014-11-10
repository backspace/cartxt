RSpec::Matchers.define :produce_response do |expected|
  match do |actual|
    GatewayRepository.gateway = double
    if expected.is_a? Hash
      expected.each do |number, response|
        expect_txt_response_to number, response
      end
    elsif expected.is_a? Array
      expected.each do |response|
        expect_txt_response response
      end
    else
      expect_txt_response expected
    end

    if actual.is_a? Hash
      actual.each do |number, txt|
        send_txt_from(number, txt)
      end
    else
      send_txt(actual)
    end
  end
end

RSpec::Matchers.alias_matcher :produce_responses, :produce_response

RSpec::Matchers.define :produce_irrelevant_response do |expected|
  match do |actual|
    GatewayRepository.gateway = double
    expect(GatewayRepository.gateway).to receive(:deliver).at_least(:once)

    if actual.is_a? Hash
      actual.each do |number, txt|
        send_txt_from(number, txt)
      end
    else
      send_txt(actual)
    end
  end
end
