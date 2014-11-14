RSpec.configure do |config|
  config.before(command: true) do
    def command
      parameters = {car: car, sharer: sharer}
      parameters.merge!(additional_parameters) if defined?(additional_parameters)
      described_class.new(parameters)
    end

    def responses
      command.tap{|command| command.execute}.responses
    end
  end
end
