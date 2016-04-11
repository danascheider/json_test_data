require_relative "./data_structures/string"
require_relative "./data_structures/number"

module JsonTestData
  class JsonSchema
    attr_accessor :schema

    def initialize(schema)
      @schema = JSON.parse(schema, symbolize_names: true)
    end

    def generate_example
      generate(schema).to_json
    end

    private
      def generate_data(obj)
        case obj.fetch(:type)
        when "number"
          JsonTestData::Number.create(obj)
        when "integer"
          JsonTestData::Number.create(obj)
        when "boolean"
          true
        when "string"
          JsonTestData::String.create(obj)
        end
      end

      def generate(obj)
        if is_object?(obj)
          generate_object(obj)
        elsif is_array?(obj)
          generate_array(obj)
        else
          generate_data(obj)
        end
      end

      def is_object?(property)
        property.fetch(:type, nil) == "object"
      end

      def is_array?(property)
        property.fetch(:type, nil) == "array"
      end

      def generate_object(object)
        obj = {}

        object.fetch(:properties).each do |k, v|
          obj[k]  = nil unless v.has_key?(:type)

          obj[k]  = generate(v)
        end

        obj
      end

      def generate_array(object)
        object.fetch(:minItems, nil) || object[:minItems] = 1

        if object.fetch(:items, nil) && object.fetch(:items).has_key?(:type)
          Array.new(object.fetch(:minItems), generate(object.fetch(:items))).compact
        else
          Array.new(object.fetch(:minItems))
        end
      end

      def array_has_min_items?(object)
        object.has_key?(:minItems)
      end
  end
end
