require_relative "./helpers/number_helper"

module JsonTestData
  class Number
    extend NumberHelper

    class << self
      def create(schema)
        if schema.has_key?(:multipleOf)
          multiple(schema.fetch(:multipleOf), schema.fetch(:minimum, nil) || 0)
        elsif schema.has_key?(:maximum) && schema.has_key?(:minimum)
          between(max: schema.fetch(:maximum), min: schema.fetch(:minimum), integer: schema.fetch(:type) == "integer")
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
