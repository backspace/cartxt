feature 'Driver says something unrecognised', :txt do
  let!(:car) { FactoryGirl.create :car }
  let!(:sharer) { FactoryGirl.create :sharer }

  scenario "They receive the commands response" do
    expect_txt_response Responses::Commands.default_body
    send_txt "hello"
  end
end
