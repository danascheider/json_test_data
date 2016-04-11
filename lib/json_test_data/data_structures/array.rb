module JsonTestData
  class Array
    class << self
      def create(schema)
        min = schema.fetch(:minItems, 0)
        ::Array.new(min)
      end
    end
  end
end
