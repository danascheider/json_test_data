require 'json'

require_relative './json_test_data/json_schema'

module JsonTestData
  def self.generate!(schema)
    JsonSchema.new(schema).generate_example
  end
end
