module Utilities
  class DynamicResponseFinder
    def initialize(response_class)
      @response_class = response_class
    end

    def response
      Response.find_by(name: searchable_class_name) || Response.new(name: searchable_class_name, body: @response_class.default_body)
    end

    private
    def searchable_class_name
      @response_class.name.demodulize.underscore
    end
  end
end
