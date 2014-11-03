module Responses
  class DynamicResponse < AbstractResponse
    def body
      if find_response
        find_response.body
      else
        default_body
      end
    end

    def self.find_or_build_response
      # FIXME hackery
      instance = new({})
      instance.send(:find_response) || Response.new(name: instance.send(:searchable_class_name))
    end

    private
    def find_response
      @response_model ||= Response.find_by(name: searchable_class_name)
    end

    def searchable_class_name
      self.class.name.demodulize.underscore
    end
  end
end
