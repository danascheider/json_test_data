require_relative "./helpers/number_helper"

module JsonTestData
  class Number
    extend NumberHelper

    class << self
      def create(schema)
        factor = schema.fetch(:multipleOf, nil)
        minimum, maximum = schema.fetch(:minimum, nil), schema.fetch(:maximum, nil)

        num = new(min: minimum, max: maximum, factor: factor)
        val = num.value

        val = if maximum && minimum
                between(min: minimum, max: maximum, integer: schema.fetch(:type) == "")
              else
                val
              end

        step_size = schema.fetch(:type) == "integer" ? 1 : 0.5

        val = ensure_multiple_of(val, factor) if factor

        val = adjust_for_maximum(number: val, maximum: maximum, step_size: factor || step_size)
        adjust_for_minimum(number: val, minimum: minimum, step_size: factor || step_size)
      end

      private

      def ensure_multiple_of(number, factor=1)
        number % factor == 0 ? number : number * factor
      end
    end

    attr_accessor :value

    def initialize(min: minimum, max: maximum, factor: nil, value: nil)
      @factor, @minimum, @maximum = factor, min, max
      @value = value || @factor || 1
    end

    def ensure_multiple_of!
      @value = factor unless value % factor == 0
    end
  end
end
