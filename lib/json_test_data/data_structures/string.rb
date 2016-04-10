module JsonTestData
  class String
    class << self
      def create(schema)
        if schema.has_key?(:maxLength)
          len = [schema.fetch(:maxLength), 6].min
          "string"[0..len - 1]
        elsif schema.has_key?(:minLength)
          "a" * schema.fetch(:minLength)
        else
          "string"
        end
      end
    end
  end
end
