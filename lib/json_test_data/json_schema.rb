require_relative "./data_structures/string"
require_relative "./data_structures/number"

module JsonTestData
  class JsonSchema
    attr_accessor :schema, :handler

    def initialize(schema, handler = nil)
      @schema = JSON.parse(schema, symbolize_names: true)
      @handler = handler
    end

    def generate_example
      generate(schema).to_json
    end

    private
      def generate_data(obj, key)
        return handler.get_data(key, obj) if handler && handler.manages_key?(key)

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

      def generate(obj, key = nil)
        if is_object?(obj)
          generate_object(obj)
        elsif is_array?(obj)
          generate_array(obj)
        else
          generate_data(obj, key)
        end
      end

      def is_object?(property)
        property.fetch(:type, nil) == "object"
      end

      def is_array?(property)
        property.fetch(:type, nil) == "array"
      end

      def resolve_ref(object, ref)
        ref = ref.split("/").map(&:to_sym)[1..-1]
        ref.each {|key| object = object.fetch(key) }
        object
      end

      def set_object(obj, schema)
        schema.has_key?(:"$ref") ? resolve_ref(obj, schema.fetch(:"$ref")) : schema
      end

      def generate_object(object)
        obj = {}

        if object.has_key?(:oneOf)
          schema_to_be_used = object.fetch(:oneOf).sample
          object = set_object(object, schema_to_be_used)
        end

        if object.has_key?(:properties)
          object.fetch(:properties).each do |k, v|
            obj[k]  = nil unless v.has_key?(:type)

            obj[k]  = generate(v, k)
          end
        end

        if object.has_key?(:minProperties) && obj.length < object.fetch(:minProperties, 0)
          (object.fetch(:minProperties) - obj.length).times do
            key = JsonTestData::String.create({type: "string"})
            obj[key] = nil
          end
        end

        obj.size == 0 ? {} : obj
      end

      def generate_array(object)
        object.fetch(:minItems, nil) || object[:minItems] = 1

        if object.fetch(:items, nil) && object.fetch(:items).has_key?(:type)
          Array.new(object.fetch(:minItems)).map { generate(object.fetch(:items)) }
        else
          Array.new(object.fetch(:minItems))
        end
      end
  end
end
