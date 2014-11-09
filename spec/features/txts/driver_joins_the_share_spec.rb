feature 'Driver joins the share', :txt do
  let!(:car) { FactoryGirl.create :car, number: 'Bot', description: "I am an ugly car." }

  let(:joiner) { FactoryGirl.create :sharer, :unknown, name: "Joiner", number: "#joiner" }
  let(:admin) { FactoryGirl.create :sharer, :admin, number: '#admin' }

  scenario 'They are asked their name and the admin approves' do
    expect(joiner.number => "join").to produce_response({
      joiner.number => "Hello there! #{car.description} To join in sharing me, please reply with your name."
    })

    expect(joiner.number => joiner.name).to produce_response({
      joiner.number => "Nice to meet you, #{joiner.name}. Please wait while I check in.",
      admin.number => "#{joiner.name}, from number #{joiner.number}, would like to join. Reply with \"approve #{joiner.number}\" (or reject)."
    })

    expect(admin.number => "approve #{joiner.number}").to produce_response({
      joiner.number => "You are now approved to share me. I understand commands like \"book\", \"borrow\", and \"status\". For a list of commands say \"commands\" and for help on a specific command like \"book\", say \"commands book\".",
      admin.number => "I have welcomed #{joiner.name} to share me."
    })
  end
end
