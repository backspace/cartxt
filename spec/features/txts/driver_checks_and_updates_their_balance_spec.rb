feature 'Driver checks and updates their balance', :txt do
  let!(:car) { create :car, lockbox_information: "The lockbox is somewhere." }
  let!(:sharer) { create :sharer, balance: 12.34 }
  let!(:admin) { create :sharer, :admin, number: '#admin' }

  scenario 'They receive a reply with their current balance' do
    expect("balance").to produce_response "Your balance owing is $12.34, with pending payments of $0.00."

    expect("pay 10.01").to produce_responses({
      sharer.number => "Place your payment in the lockbox. The lockbox is somewhere. After your pending payment of $10.01, your balance will be $2.33.",
      admin.number => "#{Formatters::Sharer.new(sharer).format} is submitting a payment of $10.01."
    })

    expect(admin.number => "collect 10.01 #{sharer.number}").to produce_response({
      admin.number => "Deducted $10.01 from the balance of #{Formatters::Sharer.new(sharer).format}. Their balance is now $2.33.",
      sharer.number => "Your payment of $10.01 has been received. Your balance owing is now $2.33."
                                                                    })
  end
end
