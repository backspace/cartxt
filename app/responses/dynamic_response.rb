module Responses
  class DynamicResponse < AbstractResponse
    def body
      Liquid::Template.parse(unrendered_body).render('sender' => Responses::Presenters::Sharer.new(@sharer), 'car' => Responses::Presenters::Car.new(@car))
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
  end
end
