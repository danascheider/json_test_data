module JsonTestData
  class String
    class << self
      def create(schema)
        return schema.fetch(:enum).sample if schema.fetch(:enum, nil)

        pattern(schema).random_example
      end

      private

      def pattern(schema)
        if schema.fetch(:format, nil)
          Regexp.new(formats.fetch(schema.fetch(:format)))
        elsif schema.fetch(:pattern, nil)
          Regexp.new(schema.fetch(:pattern))
        else
          len = schema.fetch(:maxLength, nil) || schema.fetch(:minLength, nil) || 1
          /.{#{len}}/
        end
      end

      def formats
        {
          "date-time" => "^\d{4}(\-\d{2}){2}T\d{2}\:\d{2}\:\d{2}(Z|[\+\-]\d{2}\:\d{2})$"
        }
      end
    end
  end
end
