module JsonTestData
  module NumberHelper
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

      multiplier = 2
      multiplied = factor

      while multiplied <= min
        multiplied *= multiplier
        multiplier += 1
      end

      multiplied
    end
  end
end
