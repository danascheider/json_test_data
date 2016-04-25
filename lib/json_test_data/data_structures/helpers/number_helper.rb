module JsonTestData
  module NumberHelper
    def between(min:, max:, integer: false)
      return integer ? mean(min, max).round(0) : mean(min, max)
    end

    private

    def mean(*numbers)
      numbers.inject(:+).to_f.quo(numbers.length)
    end
  end
end
