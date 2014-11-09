feature 'Admin checks who is sharing' do
  include Rack::Test::Methods

  def app
    Rails.application
  end

  let!(:car) { FactoryGirl.create :car }

  let!(:admin) { FactoryGirl.create :sharer, :admin, name: "Admin", balance: 10, pending_payments: 5.50 }

  let!(:rama) { FactoryGirl.create :sharer, name: "Rama" }
  let!(:sita) { FactoryGirl.create :sharer, name: "Sita" }

  scenario 'They receive a list of sharers' do
    GatewayRepository.gateway = double

    expect_txt_response_to admin.number, <<-TXT.strip_heredoc
      Admin #{admin.number}: $10.00 (pending $5.50)
      Rama #{rama.number}: $0.00
      Sita #{sita.number}: $0.00
    TXT

    send_txt_from admin.number, "who"
  end
end
