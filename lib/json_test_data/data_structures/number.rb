require_relative "./helpers/number_helper"

module JsonTestData
  class Number
    extend NumberHelper

    class << self
      def create(schema)
        if schema.has_key?(:multipleOf)
          multiple(schema.fetch(:multipleOf))
        elsif schema.fetch(:maximum, nil)
          maximum(schema.fetch(:maximum))
        else
          1
        end
      end
    end
  end
end
