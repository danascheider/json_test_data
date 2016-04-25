require_relative "./helpers/number_helper"

module JsonTestData
  class Number
    extend NumberHelper

    class << self
      def create(schema)
        factor = schema.fetch(:multipleOf, nil)
        minimum, maximum = schema.fetch(:minimum, nil), schema.fetch(:maximum, nil)

        num = new(min: minimum, max: maximum, factor: factor, type: schema.fetch(:type, "integer").to_sym)
        num.adjust!
      end

      private

      def ensure_multiple_of(number, factor=1)
        number % factor == 0 ? number : number * factor
      end
    end

    attr_accessor :value, :maximum, :minimum, :type, :factor, :step_size

    def initialize(min: nil, max: nil, factor: nil, value: nil, type: nil)
      @factor, @minimum, @maximum = factor, min, max
      @value = value || @factor || 1
      @type ||= :integer

      @step_size = type == :integer ? 1 : 0.5
    end

    def ensure_multiple_of!
      @value *= factor unless value % factor == 0
    end

    def adjust_for_divisibility!
      value *= factor unless value_divisible_by_factor?
    end

    def value_too_low?
      return false unless minimum
      value <= minimum
    end

    def value_too_high?
      return false unless maximum
      value >= maximum
    end

    def value_divisible_by_factor?
      return true unless factor
      value % factor == 0
    end

    def should_be_int_but_isnt?
      type == :integer && !value.is_a?(Integer)
    end

    def adjust!
      while !value_divisible_by_factor? || value_too_low? || value_too_high? || should_be_int_but_isnt?
        adjust_for_divisibility!

        if too_high?
          @value -= step_size
        end

        if too_low?
          @value += step_size
        end
      end

      @value ||= 1
    end
  end
end
