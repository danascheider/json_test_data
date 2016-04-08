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
      def object_of_type(type)
        type == "number" ? 1 : "string"
      end

      def generate_object
        obj = {}

        schema.fetch(:properties).each {|k, v| obj[k] = object_of_type(v.fetch(:type)) }

        obj.to_json
      end

      def generate_array
        arr = []

        schema.fetch(:items).each do |item|
          val = item.is_a?(Array) ? object_of_type(item.last) : item
          arr << val
        end

        arr.to_json
      end
  end
end
