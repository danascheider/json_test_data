require "pry"

module JsonTestData
  class JsonSchema
    attr_accessor :schema

    def initialize(schema)
      @schema = JSON.parse(schema, symbolize_names: true)
    end

    def generate_example
      @schema.fetch(:type) == "object" ? generate_object : generate_array
    end

    private

      def generate_object
        obj = {}

        schema.fetch(:properties).each  do |key, value|
          v = value.is_a?(Hash) ? value.fetch(:type) : value
          obj[key] = v
        end

        obj.to_json
      end

      def generate_array
        arr = []

        schema.fetch(:items).each do |item|
          val = item.is_a?(Array) ? item.last : item
          arr << val
        end

        arr.to_json
      end
  end
end
