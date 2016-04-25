module JsonTestData
  module NumberHelper
    def adjust_for_maximum(number:, maximum: nil, step_size: nil)
      return number unless maximum && number >= maximum

      num = adjust(number: number, cutoff: maximum, step_size: step_size && step_size * -1 || -1)
      adjust_for_maximum(number: num, maximum: maximum, step_size: step_size)
    end

    def adjust_for_minimum(number:, minimum: nil, step_size: nil)
      return number unless minimum && number <= minimum

      num = adjust(number: number, cutoff: minimum, step_size: step_size)
      adjust_for_minimum(number: num, minimum: minimum, step_size: step_size)
    end

    def between(min:, max:, integer: false)
      return integer ? mean(min, max).round(0) : mean(min, max)
    end

    private

    def mean(*numbers)
      numbers.inject(:+).to_f.quo(numbers.length)
    end

    def adjust(number:, cutoff:, step_size: 1)
      cutoff + step_size
    end
  end
end
