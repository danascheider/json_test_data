module JsonTestData
  module NumberHelper
    def adjust_for_maximum(number:, maximum: nil, step_size: nil)
      return number unless (maximum && number >= maximum)

      num = !!step_size ? number - step_size : maximum - 1
      adjust_for_maximum(number: num, maximum: maximum, step_size: step_size)
    end

    def adjust_for_minimum(number:, minimum: nil, step_size: nil)
      return number unless minimum && minimum >= number

      num = !!step_size ? number + step_size : minimum + 1
      adjust_for_minimum(number: num, minimum: minimum, step_size: step_size)
    end

    def between(min:, max:, integer: false)
      return integer ? mean(min, max).to_i : mean(min, max)
    end

    def mean(*numbers)
      numbers.inject(:+).to_f.quo(numbers.length)
    end

    def infinity
      Math.atanh(1)
    end
  end
end
