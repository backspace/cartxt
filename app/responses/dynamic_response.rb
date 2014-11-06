module Responses
  class DynamicResponse
    attr_reader :from, :to

    @@exposed = {}

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
      @@exposed[instance_variable] = options_hash
    end

    def template_parameters
      parameters = {}

      @@exposed.each do |instance_variable, options_hash|
        presenter_class = options_hash[:class]

        template_parameter = instance_variable_get "@#{instance_variable}"

        template_parameter = presenter_class.new(template_parameter) if presenter_class.present?

        parameters[instance_variable.to_s] = template_parameter
      end

      parameters
    end

    def extract_exposed_options(options)
      @@exposed.each do |instance_variable, options_hash|
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
    expose :car, class: Presenters::Car
    expose :sender, class: Presenters::Sharer, input_name: :sharer
  end
end
