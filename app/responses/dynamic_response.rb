module Responses
  class DynamicResponse
    attr_reader :from, :to

    class_attribute :exposed
    self.exposed = {}

    def initialize(options)
      extract_exposed_options(options)

      @sharer = @sender

      @from = @car
      @to = @sharer
    end

    def body
      Liquid::Template.parse(unrendered_body).render(template_parameters, filters: filters)
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
      new_hash = {}
      new_hash[instance_variable] = options_hash
      self.exposed = self.exposed.merge(new_hash)
    end

    def template_parameters
      parameters = {}

      self.class.exposed.each do |instance_variable, options_hash|
        template_parameter = instance_variable_get "@#{instance_variable}"

        presenter_class_name = options_hash[:presenter]

        if presenter_class_name.present?
          presenter_class = "Responses::Presenters::#{presenter_class_name}".constantize
          template_parameter = presenter_class.new(template_parameter)
        end

        parameters[instance_variable.to_s] = template_parameter
      end

      parameters
    end

    def extract_exposed_options(options)
      self.class.exposed.each do |instance_variable, options_hash|
        if options_hash[:input_name].present?
          options_value = options[options_hash[:input_name]]
        else
          options_value = options[instance_variable]
        end

        instance_variable_set "@#{instance_variable}", options_value
      end
    end

    def filters
      [Responses::Filters::Currency, Responses::Filters::Spacing]
    end

    # FIXME any way to have these at the top?
    expose :car, presenter: "Car"
    expose :sender, presenter: "Sharer", input_name: :sharer
  end
end
