module Responses
  class AbstractResponse
    attr_reader :from, :to

    def initialize(options)
      @car = options[:car]
      @sharer = options[:sharer]

      @from = @car
      @to = @sharer
    end

    protected
    # FIXME DRY but still hideous
    def afterspace_potential_content(content)
      if content.present?
        if content.is_a? Array
          to_append = content.compact.select(&:present?)

          if to_append.present?
            "#{to_append.join(" ")} "
          else
            ""
          end
        else
          "#{content} "
        end
      else
        ""
      end
    end
  end
end
