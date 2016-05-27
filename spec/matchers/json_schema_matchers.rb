require "rspec/expectations"
require "json-schema"

RSpec::Matchers.define :match_schema do |expected|
  match do |actual|
    JSON::Validator.validate(expected, actual)
  end
end

RSpec::Matchers.define :match_one_of do |expected|
  match do |actual|
    JSON::Validator.validate(expected[0], actual) || JSON::Validator.validate(expected[1], actual)
  end
end
