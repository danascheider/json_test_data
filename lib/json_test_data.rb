require 'json'
Dir['json_test_data'].each {|f| require f }

module JsonTestData
  def self.generate!(schema)
    JsonSchema.new(schema).generate_example
  end
end
