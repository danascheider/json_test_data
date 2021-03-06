require "rspec/expectations"
require "json-schema"

RSpec::Matchers.define :match_schema do |schema|
  match do |actual|
    JSON::Validator.validate!(schema, actual)
  end
end

RSpec::Matchers.define :match_one_of do |schemas|
  match do |actual|
    JSON::Validator.validate(schemas[0], actual) || JSON::Validator.validate(schemas[1], actual)
  end
end
