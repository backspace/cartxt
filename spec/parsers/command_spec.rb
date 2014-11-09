describe Parsers::Command do
  let(:txt) { Txt.new(from: :from, to: :to, body: body) }
  let(:car) { :car }

  def parsed_command
    Parsers::Command.new(txt).parse
  end

  before do
    expect(Car).to receive(:find_by).with(number: :to).and_return car
  end

  context 'when the sender exists' do
    let(:sharer) { FactoryGirl.create(:sharer, :unknown, number: :from) }

    before do
      sharer.know!
    end

    let(:body) { 'a name' }

    it 'returns a Name command' do
      name_double = double
      expect(Commands::Name).to receive(:new).with(car: car, sharer: sharer, name: body).and_return name_double

      expect(parsed_command).to be(name_double)
    end

    context 'and is named' do
      before do
        sharer.bestow_name!
      end

      context 'and is approved' do
        before do
          sharer.approve!
        end

        context 'and is an admin' do
          before do
            sharer.admin!
          end

          context 'when the command is an approval' do
            let(:body) { 'approve #somenum' }

            it 'returns an Approve command' do
              approval_double = double
              expect(Commands::Approve).to receive(:new).with(car: car, sharer: sharer, unapproved_sharer_number: '#somenum').and_return approval_double

              expect(parsed_command).to be(approval_double)
            end
          end

          context 'when the command is a rejection' do
            let(:body) { 'reject #somenum' }

            it 'returns a Reject command' do
              reject_double = double
              expect(Commands::Reject).to receive(:new).with(car: car, sharer: sharer, unapproved_sharer_number: '#somenum').and_return reject_double

              expect(parsed_command).to be(reject_double)
            end
          end

          context 'when the command is a payment collection' do
            let(:body) { 'collect X Y' }

            it 'returns a Collect command' do
              expect(Commands::Collect).to receive(:new).with(car: car, sharer: sharer, collection_string: 'X Y').and_return(collect = double)
              expect(parsed_command).to be(collect)
            end
          end

          context "when the command is a who request" do
            let(:body) { "who" }

            it "returns a Who command" do
              expect(Commands::Who).to receive(:new).with(car: car, sharer: sharer).and_return(who = double)
              expect(parsed_command).to be(who)
            end
          end
        end

        context 'when the command is the command request' do
          let(:body) { 'commands x' }

          it 'returns the Commands command' do
            commands_double = double
            expect(Commands::Commands).to receive(:new).with(car: car, sharer: sharer, parameter: 'x').and_return commands_double

            expect(parsed_command).to be(commands_double)
          end
        end

        context 'when the command is a status request' do
          let(:body) { 'status' }

          it 'it returns a Status command' do
            status_double = double
            expect(Commands::Status).to receive(:new).with(car: car, sharer: sharer).and_return status_double

            expect(parsed_command).to be(status_double)
          end
        end

        context 'when the command is an odometer report' do
          let(:body) { '555' }

          it 'returns an OdometerReport command' do
            report_double = double
            expect(Commands::OdometerReport).to receive(:new).with(car: car, sharer: sharer, reading: body).and_return report_double
            expect(parsed_command).to be(report_double)
          end
        end

        context 'when the command is a borrow request' do
          let(:body) { 'borrow' }

          it 'returns a Borrow command' do
            borrow_double = double
            expect(Commands::Borrow).to receive(:new).with(car: car, sharer: sharer).and_return borrow_double

            expect(parsed_command).to be(borrow_double)
          end
        end

        context 'when the command is a return request' do
          let(:body) { 'return' }

          it 'returns a Return command' do
            return_double = double
            expect(Commands::Return).to receive(:new).with(car: car, sharer: sharer).and_return return_double

            expect(parsed_command).to be(return_double)
          end
        end

        context 'when the command is a balance request' do
          let(:body) { 'balance' }

          it 'returns a Balance command' do
            balance_double = double
            expect(Commands::Balance).to receive(:new).with(car: car, sharer: sharer).and_return balance_double

            expect(parsed_command).to be(balance_double)
          end
        end

        context 'when the command is a book request' do
          let(:body) { 'book something else and  so on' }

          it 'returns a Book command' do
            book = double
            expect(Commands::Book).to receive(:new).with(car: car, sharer: sharer, booking_string: "something else and  so on").and_return book

            expect(parsed_command).to be(book)
          end
        end

        context 'when the command is a join request' do
          let(:body) { 'join' }

          it 'returns a Join command' do
            join = double
            expect(Commands::Join).to receive(:new).with(car: car, sharer: sharer).and_return join

            expect(parsed_command).to be(join)
          end
        end
      end

      context 'when the command is a gas purchase' do
        let(:body) { 'gas X' }

        it 'returns a Gas command' do
          expect(Commands::Gas).to receive(:new).with(car: car, sharer: sharer, cost_string: 'X').and_return(gas = double)
          expect(parsed_command).to be(gas)
        end
      end

      context 'when the command is a payment' do
        let(:body) { 'pay X' }

        it 'returns a Pay command' do
          expect(Commands::Pay).to receive(:new).with(car: car, sharer: sharer, amount_string: 'X').and_return(pay = double)
          expect(parsed_command).to be(pay)
        end
      end

      context 'when the command is a booking confirmation' do
        let(:body) { 'confirm' }

        it 'returns a Confirm command' do
          expect(Commands::Confirm).to receive(:new).with(car: car, sharer: sharer).and_return(confirm = double)
          expect(parsed_command).to be(confirm)
        end
      end

      context 'when the command is a booking abandonment' do
        let(:body) { 'abandon' }

        it 'returns a Abandon command' do
          expect(Commands::Abandon).to receive(:new).with(car: car, sharer: sharer).and_return(abandon = double)
          expect(parsed_command).to be(abandon)
        end
      end

      context 'when the command is unknown' do
        let(:body) { 'something' }

        it 'returns the Commands command' do
          expect(Commands::Commands).to receive(:new).with(car: car, sharer: sharer).and_return(commands = double)
          expect(parsed_command).to be(commands)
        end
      end

      context 'and the sender is rejected' do
        before do
          sharer.reject!
        end

        let(:body) { 'anything' }

        it 'returns a ForwardRejection command' do
          forward = double
          expect(Commands::ForwardRejection).to receive(:new).with(car: car, sharer: sharer, txt: body).and_return forward

          expect(parsed_command).to be(forward)
        end
      end
    end
  end
end
