module JsonTestData
  class String
    class << self
      def create(schema)
        len = schema.fetch(:maxLength, nil) || schema.fetch(:minLength, nil) || 1
        "a" * len
      end
    end
  end
end
