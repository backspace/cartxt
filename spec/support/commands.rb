RSpec.configure do |config|
  config.before(command: true) do
    def command
      described_class.new(car: car, sharer: sharer)
    end

    def responses
      command.tap{|command| command.execute}.responses
    end
  end
end
