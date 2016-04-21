module JsonTestData
  class String
    extend RegXing

    class << self
      def create(schema)
        len = schema.fetch(:maxLength, nil) || schema.fetch(:minLength, nil) || 1
        Generator.new(/.{#{len}}/).generate!
      end
    end
  end
end
