require 'json'

module JsonTestData
  def self.generate!(schema)
    schema = JSON.parse(schema)
    schema.fetch("type") == "object" ? {}.to_json : [].to_json
  end
end
