require_relative "./helpers/number_helper"

module JsonTestData
  class Number
    extend NumberHelper

    class << self
      def create(schema)
        if schema.has_key?(:multipleOf)
          multiple(schema.fetch(:multipleOf))
        elsif schema.has_key?(:maximum)
          maximum(schema.fetch(:maximum))
        elsif schema.has_key?(:minimum)
          minimum(schema.fetch(:minimum))
        else
          1
        end
      end
    end
  end
end
