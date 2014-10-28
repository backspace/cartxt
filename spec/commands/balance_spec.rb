describe Commands::Balance do
  let(:car) { :car }
  let(:sharer) { double(balance: 23.45) }

  it 'generates a balance response' do
    balance = Commands::Balance.new(car: car, sharer: sharer)
    balance.execute

    expect(balance).to have_response_from_car("Your current balance is $23.45.")
  end
end
