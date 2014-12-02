feature 'Driver joins the share', :txt do
  let!(:car) { create :car, number: 'Bot', description: "The car is an ugly car." }

  let(:joiner) { create :sharer, :unknown, name: "Joiner", number: "#joiner" }
  let(:admin) { create :sharer, :admin, number: '#admin' }

  scenario 'They are asked their name and the admin approves' do
    expect(joiner.number => "join").to produce_response({
      joiner.number => "#{car.description} To join in sharing the car, please reply with your name."
    })

    expect(joiner.number => joiner.name).to produce_response({
      joiner.number => "Thank you, #{joiner.name}. Please wait to be approved.",
      admin.number => "#{joiner.name}, from number #{joiner.number}, would like to join. Reply with \"approve #{joiner.number}\" (or reject)."
    })

    expect(admin.number => "approve #{joiner.number}").to produce_response({
      joiner.number => "You are now approved to share the car. You can use commands like \"book\", \"borrow\", and \"status\". For a list of commands say \"commands\" and for help on a specific command like \"book\", say \"commands book\".",
      admin.number => "Welcomed #{joiner.name} to share the car."
    })
  end
end
