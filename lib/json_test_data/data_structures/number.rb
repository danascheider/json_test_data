require_relative "./helpers/number_helper"

module JsonTestData
  class Number
    extend NumberHelper

    class << self
      def create(schema)
        factor = schema.fetch(:multipleOf, nil)
        minimum, maximum = schema.fetch(:minimum, nil), schema.fetch(:maximum, nil)

        num = new(min: minimum, max: maximum, factor: factor, type: schema.fetch(:type, :integer))

        val = num.value

        val = if maximum && minimum
                between(min: minimum, max: maximum, integer: num.type == :integer)
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

    attr_accessor :value, :maximum, :minimum, :type

    def initialize(min: nil, max: nil, factor: nil, value: nil, type: nil)
      @factor, @minimum, @maximum = factor, min, max
      @value = value || @factor || 1
      @type ||= :integer
    end

    def ensure_multiple_of!
      @value = factor unless value % factor == 0
    end

    def ensure_in_range!
      between(maximum)
      @value = maximum - 1 if value > maximum
      @value = minimum + 1 if value < minimum
    end
  end
end
