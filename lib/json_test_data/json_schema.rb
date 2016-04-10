require_relative "./data_structures/string"

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
          1
        when "integer"
          1
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
        property.fetch(:type) == "object"
      end

      def is_array?(property)
        property.fetch(:type) == "array"
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
        return [] unless object.fetch(:items).has_key?(:type)

        [generate(object.fetch(:items))].compact
      end
  end
end
