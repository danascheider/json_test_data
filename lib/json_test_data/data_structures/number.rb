require_relative "./helpers/number_helper"

module JsonTestData
  class Number
    extend NumberHelper

    class << self
      def create(schema)
        factor = schema.fetch(:multipleOf, nil)
        minimum, maximum = schema.fetch(:minimum, nil), schema.fetch(:maximum, nil)

        num = new(min: minimum, max: maximum, factor: factor, type: schema.fetch(:type, "number").to_sym)
        num.adjust!
      end

      private

      def ensure_multiple_of(number, factor=1)
        number % factor == 0 ? number : number * factor
      end
    end

    attr_accessor :value, :maximum, :minimum, :type, :factor

    def initialize(min: nil, max: nil, factor: nil, value: nil, type: nil)
      @factor, @minimum, @maximum = factor, min, max
      @value = value || @factor || 1
      @type ||= :number
    end

    def step_size
      return @step_size ||= is_int? ? 1 : 0.5 unless minimum && maximum

      @step_size ||= Number.between(min: minimum, max: maximum, integer: type == :integer) / 3
      @step_size.round(2)
    end

    def ensure_multiple_of!
      @value *= factor unless value % factor == 0
    end

    def adjust_for_divisibility!
      return if value_divisible_by_factor?
      @value *= factor
    end

    def is_int?
      type == :integer
    end

    def value_too_low?
      return false unless minimum
      @value <= minimum
    end

    def value_too_high?
      return false unless maximum
      @value >= maximum
    end

    def value_divisible_by_factor?
      return true unless factor
      @value % factor == 0
    end

    def should_be_int_but_isnt?
      type == :integer && !@value.is_a?(Integer)
    end

    def adjust!
      while !value_divisible_by_factor? || value_too_low? || value_too_high? || should_be_int_but_isnt?
        adjust_for_divisibility!

        if value_too_high?
          @value -= step_size
        end

        if value_too_low?
          @value += step_size
        end
      end

      @value ||= 1
    end
  end
end
