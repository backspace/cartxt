feature 'Driver asks for help', :txt do
  let!(:car) { create :car }
  let!(:sharer) { create :sharer }

  let(:commands_response) do
    <<-TXT.strip_heredoc
      Available commands:

      balance
      book, confirm, abandon, bookings
      borrow, return

      gas

      pay

      status

      email


      For help on a specific command, say:
      \"commands commandname\"
    TXT
  end

  scenario 'They ask for the commands' do
    expect("commands").to produce_response(commands_response)
  end

  scenario 'They ask for help on different commands' do
    expect("commands balance").to produce_response "balance: tells you your current balance owing, including any payments you have made that have not been received."

    # FIXME is it useful to repeat the default bodies in this spec?
    expect("commands book").to produce_response Responses::CommandsBook.default_body

    expect("commands confirm").to produce_response "confirm: when you have issued a \"book\" command, use \"confirm\" to confirm that the booking start and end were correctly interpreted."

    expect("commands abandon").to produce_response "abandon: when you have issued a \"book\" command, use \"abandon\" to abandon it before confirming it."

    expect("commands borrow").to produce_response "borrow: start the process of borrowing the car right now."

    expect("commands return").to produce_response "return: after you are done with the car, say \"return\" to start the process of returning it."

    expect("commands gas").to produce_response "gas: when you are borrowing the car and need to buy gas, send \"gas 15.50\" or however much you buy. Submit the receipt when you return the key and the gas will be subtracted from your balance owing."

    expect("commands pay").to produce_response "pay: to register and submit a payment, send \"pay 13.50\" or however much you submit. Place your payment with the key and it will be subtracted from your balance owing when it is collected."

    expect("commands status").to produce_response "status: tells you whether the car is currently available."
  end

  context 'when they are an admin' do
    before do
      sharer.role = :admin
      sharer.save
    end

    scenario "They also receive the admin commands response" do
      expect("commands").to produce_responses [
        commands_response,
        <<-TXT.strip_heredoc
        Admin commands:

        approve, reject
        collect
        who
        TXT
      ]
    end
  end
end
