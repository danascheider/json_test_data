module JsonTestData
  class String
    class << self
      def create(schema)
        return schema.fetch(:enum).sample if schema.fetch(:enum, nil)

        len    = schema.fetch(:maxLength, nil) || schema.fetch(:minLength, nil) || 1
        ptn    = schema.fetch(:pattern, nil) && Regexp.new(schema.fetch(:pattern))
        regexp = ptn ? ptn.random_example : /.{#{len}}/.random_example
      end
    end
  end
end
