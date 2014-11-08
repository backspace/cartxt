feature 'Driver asks for help' do
  include Rack::Test::Methods

  def app
    Rails.application
  end

  let!(:car) { FactoryGirl.create :car }
  let!(:sharer) { FactoryGirl.create :sharer }

  let(:commands_response) do
    <<-TXT.strip_heredoc
      Available commands:

      balance
      book, confirm, cancel
      borrow, return

      gas

      pay

      status


      For help on a specific command, say:
      \"commands commandname\"
    TXT
  end

  scenario 'They ask for the commands' do
    GatewayRepository.gateway = double

    expect_txt_response commands_response
    send_txt "commands"
  end

  scenario 'They ask for help on different commands' do
    GatewayRepository.gateway = double

    expect_txt_response "balance: tells you your current balance owing, including any payments you have made that have not been received."
    send_txt "commands balance"

    # FIXME is it useful to repeat the default bodies in this spec?
    expect_txt_response Responses::CommandsBook.default_body
    send_txt "commands book"

    expect_txt_response "confirm: when you have issued a \"book\" command, use \"confirm\" to confirm that the booking start and end were correctly interpreted."
    send_txt "commands confirm"

    expect_txt_response "cancel: when you have issued a \"book\" command, use \"cancel\" to cancel it before confirming it."
    send_txt "commands cancel"

    expect_txt_response "borrow: start the process of borrowing the car right now."
    send_txt "commands borrow"

    expect_txt_response "return: after you are done with the car, say \"return\" to start the process of returning it."
    send_txt "commands return"

    expect_txt_response "gas: when you are borrowing the car and need to buy gas, send \"gas 15.50\" or however much you buy. Submit the receipt when you return the key and the gas will be subtracted from your balance owing."
    send_txt "commands gas"

    expect_txt_response "pay: to register and submit a payment, send \"pay 13.50\" or however much you submit. Place your payment with the key and it will be subtracted from your balance owing when it is collected."
    send_txt "commands pay"

    expect_txt_response "status: tells you whether the car is currently available."
    send_txt "commands status"
  end

  context 'when they are an admin' do
    before do
      sharer.role = :admin
      sharer.save
    end

    scenario "They also receive the admin commands response" do
      GatewayRepository.gateway = double

      expect_txt_response commands_response
      expect_txt_response <<-TXT.strip_heredoc
        Admin commands:

        approve, reject
        collect
      TXT
      send_txt "commands"
    end
  end
end
