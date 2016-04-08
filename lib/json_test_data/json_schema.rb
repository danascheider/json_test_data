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

      def generate_object(object)
        obj = {}

        object.fetch(:properties).each do |k, v|
          obj[k]  = nil unless v.has_key?(:type)

          obj[k]  = if v.fetch(:type) == "object"
                      generate_object(v)
                    elsif v.fetch(:type) == "array"
                      generate_array(v)
                    else
                      object_of_type(v.fetch(:type))
                    end
        end

        obj
      end

      def generate_array(object)
        return [] unless object.fetch(:items).has_key?(:type)

        val = if object.fetch(:items).fetch(:type) == "object"
                generate_object(object.fetch(:items))
              elsif object.fetch(:items).fetch(:type) == "array"
                generate_array(object.fetch(:items))
              else
                object_of_type(object.fetch(:items).fetch(:type))
              end

        [val].compact
      end
  end
end
