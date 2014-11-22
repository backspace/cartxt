describe Commands::Email do
  let(:car) { :car }
  let(:sharer) { double(:sharer) }
  let(:address) { :address }
  let(:context) { double :context }

  it "sets the sharer's email and responds" do
    email = Commands::Email.new(car: car, sharer: sharer, address: address, context: context)

    expect(sharer).to receive(:email=).with(address)
    expect(sharer).to receive(:save)

    expect(context).to receive(:[]).with(:host).and_return :host
    expect(Rails.application.routes.url_helpers).to receive(:root_url).with(host: :host).and_return :site_url
    expect(Rails.application.routes.url_helpers).to receive(:new_user_registration_url).with(host: :host).and_return :sign_up_url

    expect(Responses::Email).to receive(:new).with(car: car, sharer: sharer, site_url: :site_url, sign_up_url: :sign_up_url).and_return(response = double)

    email.execute

    expect(email.responses).to include(response)
  end
end
