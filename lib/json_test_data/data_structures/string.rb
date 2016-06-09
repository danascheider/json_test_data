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
          "date-time" => /^20\d{2}\-((0[1-9])|(1[0-2]))\-((0[1-9])|([1-2]\d))T(([0-1]\d)|(2[0-3]))\:[0-5]\d\:[0-5]\d(Z|[\+\-]\d{2}\:(0|3)0)$/,
          "email"     => /^\S+@\S+\.\S{1,5}$/,
          "hostname"  => /^[A-Za-z][A-Za-z0-9\-]*[A-Za-z0-9]$/,
          "uri"       => /^https?\:\/\/\S{1,10}\.\S{1,10}\.\S{2,5}$/
        }
      end
    end
  end
end
