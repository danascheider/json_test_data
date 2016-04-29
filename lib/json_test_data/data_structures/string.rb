module JsonTestData
  class String
    class << self
      def create(schema)
        return schema.fetch(:enum).sample if schema.fetch(:enum, nil)
        len = schema.fetch(:maxLength, nil) || schema.fetch(:minLength, nil) || 1
        RegXing::Generator.new(/.{#{len}}/).generate!
      end
    end
  end
end
