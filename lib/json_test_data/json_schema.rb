module JsonTestData
  class JsonSchema
    attr_accessor :schema

    def initialize(schema)
      @schema = JSON.parse(schema, symbolize_names: true)
    end

    def generate_example
      @schema.fetch(:type) == "object" ? generate_object(schema).to_json : generate_array(schema).to_json
    end

    private
      def object_of_type(type)
        case type
        when "number"
          1
        when "integer"
          1
        when "boolean"
          true
        when "string"
          "string"
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

          obj[k]  = if is_object?(v)
                      generate_object(v)
                    elsif is_array?(v)
                      generate_array(v)
                    else
                      object_of_type(v.fetch(:type))
                    end
        end

        obj
      end

      def generate_array(object)
        return [] unless (items = object.fetch(:items)).has_key?(:type)

        val = if is_object?(items)
                generate_object(items)
              elsif is_array?(items)
                generate_array(items)
              else
                object_of_type(items.fetch(:type))
              end

        [val].compact
      end
  end
end
