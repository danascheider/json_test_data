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

        schema.fetch(:properties).each  {|key, value| obj[key] = value.fetch(:type) }

        obj.to_json
      end

      def generate_array
        [].to_json
      end
  end
end
