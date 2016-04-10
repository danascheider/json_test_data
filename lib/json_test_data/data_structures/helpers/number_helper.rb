module JsonTestData
  module NumberHelper
    def adjust_for_maximum(number:, maximum: nil, step_size: nil)
      return number unless (maximum && maximum < number)

      num = !!step_size ? number - step_size : maximum
      adjust_for_maximum(number: num, maximum: maximum, step_size: step_size)
    end

    def adjust_for_minimum(number:, minimum:, step_size: nil)
      return number unless minimum && minimum > number

      num = !!step_size ? number + step_size : minimum

      adjust_for_minimum(number: num, minimum: minimum, step_size: step_size)
    end

    def maximum(max = nil)
      max - 1
    end

    def minimum(min = nil)
      min + 1
    end

    def between(min:, max:, integer: false)
      return integer ? mean(min, max).to_i : mean(min, max)
    end

    def mean(*numbers)
      numbers.inject(:+).to_f.quo(numbers.length)
    end

    def multiple(factor, min = 0)
      return factor if factor > min

      multiplier, multiplied = 2, factor

      while multiplied <= min
        multiplied *= multiplier
        multiplier += 1
      end

      multiplied
    end

    def infinity
      Math.atanh(1)
    end
  end
end
