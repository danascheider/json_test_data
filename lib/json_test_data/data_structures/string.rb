module JsonTestData
  class String
    class << self
      def create(schema)
        return schema.fetch(:enum).sample if schema.fetch(:enum, nil)
        return generate_date if schema.fetch(:format, nil) == "date-time"

        pattern(schema).random_example
      end

      private

      def generate_date
        require "date"
        ::DateTime.new(rand(2000..2100), rand(1..12), rand(1..28),rand(0..23), rand(60), rand(60)).iso8601
      end

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
          "email"     => /^\S+@\S+\.\S{1,5}$/,
          "hostname"  => /^[A-Za-z][A-Za-z0-9\-]*[A-Za-z0-9]$/,
          "uri"       => /^https?\:\/\/\S{1,10}\.\S{1,10}\.\S{2,5}$/
        }
      end
    end
  end
end
