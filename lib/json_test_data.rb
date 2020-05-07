# frozen_string_literal: true

require "json"
require "regexp-examples"

require_relative "./json_test_data/json_schema"

module JsonTestData
  def self.generate!(schema, opts={})
    schema = JsonSchema.new(schema, opts[:handler]).generate_example
    opts[:ruby] ? JSON.parse(schema, symbolize_names: true) : schema
  end
end
