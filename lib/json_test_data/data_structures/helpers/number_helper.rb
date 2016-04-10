module JsonTestData
  module NumberHelper
    def multiple(factor = nil)
      factor
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
  end
end
