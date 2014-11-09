feature 'Rejected sharer sends a txt', :txt do
  before do
    FactoryGirl.create(:car)
  end

  let(:admin) { FactoryGirl.create :sharer, :admin, number: "#admin" }
  let(:rejected) { FactoryGirl.create :sharer, :rejected }

  let(:txt) { 'Hi!!!!' }

  scenario 'Their message is forwarded to the admin' do
    expect_txt_response_to admin.number, "Rejected sharer #{rejected.name} #{rejected.number} sent this and I ignored it: #{txt}"
    send_txt_from rejected.number, txt
  end
end
