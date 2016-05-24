require "coveralls"

Coveralls.wear! if ENV["COVERAGE"] == "true"

require_relative "../../lib/json_test_data"
require_relative "../../lib/json_test_data/json_schema"
require_relative "../../spec/matchers/json_schema_matchers"
