feature 'Driver joins the share', :txt do
  include Rack::Test::Methods

  def app
    Rails.application
  end

  let!(:car) { FactoryGirl.create :car, number: 'Bot', description: "I am an ugly car." }

  let(:joiner) { FactoryGirl.create :sharer, :unknown, name: "Joiner", number: "#joiner" }
  let(:admin) { FactoryGirl.create :sharer, :admin, number: '#admin' }

  scenario 'They are asked their name and the admin approves' do
    expect_txt_response_to joiner.number, "Hello there! #{car.description} To join in sharing me, please reply with your name."
    send_txt_from joiner.number, 'join'

    expect_txt_response_to joiner.number, "Nice to meet you, #{joiner.name}. Please wait while I check in."
    expect_txt_response_to admin.number, "#{joiner.name}, from number #{joiner.number}, would like to join. Reply with \"approve #{joiner.number}\" (or reject)."
    send_txt_from joiner.number, joiner.name

    expect_txt_response_to joiner.number, "You are now approved to share me. I understand commands like \"book\", \"borrow\", and \"status\". For a list of commands say \"commands\" and for help on a specific command like \"book\", say \"commands book\"."
    expect_txt_response_to admin.number, "I have welcomed #{joiner.name} to share me."
    send_txt_from admin.number, "approve #{joiner.number}"
  end
end
