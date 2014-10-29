describe Commands::Approve do
  let(:car) { :car }
  let(:sharer) { double }

  it 'approves unapproved sharers' do
    unapproved_sharer = double(name: :unapproved_name, number: :unapproved_number)

    approve = Commands::Approve.new(car: car, sharer: sharer, unapproved_sharer_number: unapproved_sharer.number)

    expect(Sharer).to receive(:find_by).with(status: 'unapproved', number: unapproved_sharer.number).and_return(unapproved_sharer)

    expect(unapproved_sharer).to receive(:approve!)

    approval_admin_response = double
    expect(Responses::ApprovalAdmin).to receive(:new).with(car: car, admin: sharer, approvee: unapproved_sharer).and_return approval_admin_response

    approval_approvee_response = double
    expect(Responses::Approval).to receive(:new).with(car: car, approvee: unapproved_sharer).and_return approval_approvee_response

    approve.execute

    expect(approve.responses).to include(approval_admin_response)
    expect(approve.responses).to include(approval_approvee_response)
  end
end

