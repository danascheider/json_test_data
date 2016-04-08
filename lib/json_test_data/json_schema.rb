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

        obj
      end

      def generate_array(object)
        arr = []

        val = if object.fetch(:items).fetch(:type) == "object"
                generate_object(object.fetch(:items))
              else
                object_of_type(object.fetch(:items).fetch(:type))
              end

        arr << val
        arr
      end
  end
end
