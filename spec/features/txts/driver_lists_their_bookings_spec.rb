feature "Driver lists their bookings", :txt do
  let!(:car) { create :car }
  let!(:sharer) { create :sharer }

  scenario "They see their bookings" do
    expect("book tomorrow from 8a to 9a").to produce_irrelevant_response
    expect("confirm").to produce_irrelevant_response

    expect("book tomorrow from 7p to 9p").to produce_irrelevant_response
    expect("confirm").to produce_irrelevant_response

    expect("bookings").to produce_response <<-TXT.strip_heredoc
      Your bookings:
      tomorrow from 8:00AM to 9:00AM
      tomorrow from 7:00PM to 9:00PM
    TXT
  end
end
