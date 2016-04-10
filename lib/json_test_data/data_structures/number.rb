module JsonTestData
  class Number
    class << self
      def create(schema)
        schema.fetch(:multipleOf, nil) || 1
      end
    end
  end
end
