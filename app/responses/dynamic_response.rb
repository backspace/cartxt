module Responses
  class DynamicResponse < AbstractResponse
    def body
      Liquid::Template.parse(unrendered_body).render('sender_name' => @sharer.name)
    end

    def self.find_or_build_response
      Utilities::DynamicResponseFinder.new(self).response
    end

    private
    def find_response
      self.class.find_or_build_response
    end

    def searchable_class_name
      self.class.name.demodulize.underscore
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
  end
end
