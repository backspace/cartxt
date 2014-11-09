feature 'Admin checks who is sharing', :txt do
  let!(:car) { FactoryGirl.create :car }

  let!(:admin) { FactoryGirl.create :sharer, :admin, name: "Admin", balance: 10, pending_payments: 5.50 }

  let!(:rama) { FactoryGirl.create :sharer, name: "Rama" }
  let!(:sita) { FactoryGirl.create :sharer, name: "Sita" }

  scenario 'They receive a list of sharers' do
    expect("who").to produce_response({admin.number => <<-TXT.strip_heredoc
      Admin #{admin.number}: $10.00 (pending $5.50)
      Rama #{rama.number}: $0.00
      Sita #{sita.number}: $0.00
    TXT
    })
  end
end
