module Responses
  class DynamicResponse < AbstractResponse
    @@exposed = {}

    def initialize(options)
      super

      extract_exposed_options(options)
    end

    def body
      Liquid::Template.parse(unrendered_body).render(template_parameters)
    end

    def self.find_or_build_response
      Utilities::DynamicResponseFinder.new(self).response
    end

    private
    def find_response
      self.class.find_or_build_response
    end

    def unrendered_body
      find_response.body
    end

    def self.description(description = nil)
      if description
        @description = description
      else
        @description
      end
    end

    def self.expose(instance_variable, options_hash = {})
      @@exposed[instance_variable] = options_hash
    end

    def template_parameters
      default_parameters = {'sender' => Responses::Presenters::Sharer.new(@sharer), 'car' => Responses::Presenters::Car.new(@car)}

      @@exposed.each do |instance_variable, options_hash|
        presenter_class = options_hash[:class]

        template_parameter = instance_variable_get "@#{instance_variable}"

        template_parameter = presenter_class.new(template_parameter) if presenter_class.present?

        default_parameters[instance_variable.to_s] = template_parameter
      end

      default_parameters
    end

    def extract_exposed_options(options)
      @@exposed.keys.each do |instance_variable|
        instance_variable_set "@#{instance_variable}", options[instance_variable]
      end
    end
  end
end
