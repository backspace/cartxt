feature 'Txts are logged', :txt do
  scenario 'A user can view the txts' do
    GatewayRepository.gateway = NullGateway.new

    admin = create(:user, :admin)
    signin(admin.email, admin.password)

    create(:car)
    create :sharer
    send_txt 'status'

    visit txts_path
    expect(page).to have_content 'status'
  end
end
