describe Formatters::Sharer do
  subject { Formatters::Sharer.new(sharer).format }

  context 'with a named sharer' do
    let!(:sharer) { FactoryGirl.create :sharer, name: "Francine", number: "#123" }

    it { should eq("Francine #123") }
  end
end
