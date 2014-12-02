feature 'Rejected sharer sends a txt', :txt do
  before do
    create(:car)
  end

  let(:admin) { create :sharer, :admin, number: "#admin" }
  let(:rejected) { create :sharer, :rejected }

  let(:txt) { 'Hi!!!!' }

  scenario 'Their message is forwarded to the admin' do
    expect(rejected.number => txt).to produce_response({admin.number => "Rejected sharer #{rejected.name} #{rejected.number} sent this but it was ignored: #{txt}"})
  end
end
