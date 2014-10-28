feature 'Driver joins the share' do
  include Rack::Test::Methods

  def app
    Rails.application
  end

  before do
    Car.create(number: 'Bot')
  end

  let(:joiner) { Sharer.new(name: 'Joiner', number: "#joiner") }
  let(:admin) { Sharer.create(name: 'Admin', number: "#admin", role: 'admin') }

  scenario 'They are asked their name and the admin approves' do
    GatewayRepository.gateway = double

    expect_txt_response_to joiner.number, "To join the car share, please reply with your name."
    send_txt_from joiner.number, 'join'

    expect_txt_response_to joiner.number, "Nice to meet you, #{joiner.name}. Please await admin approval."
    expect_txt_response_to admin.number, "#{joiner.name}, from number #{joiner.number}, would like to join. Reply with \"approve #{joiner.number}\" (or reject)."
    send_txt_from joiner.number, joiner.name

    expect_txt_response_to joiner.number, "You were approved by an admin! Welcome to the car share."
    expect_txt_response_to admin.number, "We have welcomed #{joiner.name} to the car share."
    send_txt_from admin.number, "approve #{joiner.number}"
  end
end
