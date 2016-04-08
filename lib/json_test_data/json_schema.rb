module JsonTestData
  class JsonSchema
    attr_accessor :schema

    def initialize(schema)
      @schema = JSON.parse(schema, symbolize_names: true)
    end

    def generate_example
      @schema.fetch(:type) == "object" ? generate_object(schema) : generate_array(schema)
    end

    private
      def object_of_type(type)
        case type
        when "number" || "integer"
          1
        when "boolean"
          true
        when "string"
          "string"
        end
      end

      def generate_object(object)
        obj = {}

        object.fetch(:properties).each do |k, v|
          obj[k] = v.fetch(:type) == "object" ? generate_object(v) : object_of_type(v.fetch(:type))
        end

        obj.to_json
      end

      def generate_array(object)
        arr = []

        object.fetch(:items).each do |item|
          val = item.is_a?(Array) ? object_of_type(item.last) : item
          arr << val
        end

        arr.to_json
      end
  end
end
