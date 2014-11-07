feature 'Driver asks for help' do
  include Rack::Test::Methods

  def app
    Rails.application
  end

  let!(:car) { FactoryGirl.create :car }
  let!(:sharer) { FactoryGirl.create :sharer }

  let(:commands_response) do
    <<-TXT.strip_heredoc
      Available commands:

      balance
      book, confirm, cancel
      borrow, return

      gas

      pay

      status
    TXT
  end

  scenario 'They ask for the commands' do
    GatewayRepository.gateway = double

    expect_txt_response commands_response
    send_txt "commands"
  end

  context 'when they are an admin' do
    before do
      sharer.role = :admin
      sharer.save
    end

    scenario "They also receive the admin commands response" do
      GatewayRepository.gateway = double

      expect_txt_response commands_response
      expect_txt_response <<-TXT.strip_heredoc
        Admin commands:

        approve, reject
        collect
      TXT
      send_txt "commands"
    end
  end
end
