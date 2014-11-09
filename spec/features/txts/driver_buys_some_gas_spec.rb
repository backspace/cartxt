feature 'Driver buys some gas', :txt do
  let!(:car) { FactoryGirl.create :car }
  let!(:sharer) { FactoryGirl.create :sharer, balance: 20 }

  scenario 'They receive a reply with their new balance' do
    expect_txt_response "Deducted your gas cost of $5.00. Your pending balance owing is now $15.00. Please submit the receipt when you return the key."
    send_txt "gas $5"

    expect_txt_response "Your balance owing is $20.00, with pending payments of $5.00."
    send_txt "balance"
  end
end
