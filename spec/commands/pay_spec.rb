describe Commands::Pay do
  let(:car) { :car }
  let(:sharer) { double(balance: 10, pending_payments: 5) }

  let(:amount_string) { double(:amount_string) }

  it "adds the amount to the sharer's pending payments" do
    pay = Commands::Pay.new(car: car, sharer: sharer, amount_string: amount_string)

    expect(Parsers::Currency).to receive(:new).with(amount_string).and_return(parser = double(:currency_parser))
    expect(parser).to receive(:parse).and_return(parsed_amount = 2)

    expect(sharer).to receive(:pending_payments=).with(sharer.pending_payments + parsed_amount)
    expect(sharer).to receive(:save)

    admin = double(number: :number)
    expect(Sharer).to receive(:admin).and_return [admin]

    expect(Responses::Pay).to receive(:new).with(car: car, sharer: sharer, amount: parsed_amount).and_return response = double
    expect(Responses::PayAdminNotification).to receive(:new).with(car: car, admin: admin, sharer: sharer, amount: parsed_amount).and_return admin_response = double

    pay.execute

    expect(pay.responses).to include(response)
    expect(pay.responses).to include(admin_response)
  end
end
