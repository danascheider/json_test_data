require 'json'
require 'regxing'

require_relative './json_test_data/json_schema'

module JsonTestData
  def self.generate!(schema, opts={})
    schema = JsonSchema.new(schema).generate_example
    opts[:ruby] ? JSON.parse(schema) : schema
  end
end
