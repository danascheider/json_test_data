# JSON Test Data Generator
[![Gem Version](https://badge.fury.io/rb/json_test_data.svg)](https://badge.fury.io/rb/json_test_data)  [![Build Status](https://travis-ci.org/danascheider/json_test_data.svg?branch=master)](https://travis-ci.org/danascheider/json_test_data)  [![Code Climate](https://codeclimate.com/github/danascheider/json_test_data/badges/gpa.svg)](https://codeclimate.com/github/danascheider/json_test_data)
[![Coverage Status](https://coveralls.io/repos/github/danascheider/json_test_data/badge.svg?branch=master)](https://coveralls.io/github/danascheider/json_test_data?branch=master)  [![Dependency Status](https://gemnasium.com/badges/github.com/danascheider/json_test_data.svg)](https://gemnasium.com/github.com/danascheider/json_test_data)

The JSON test data generator takes JSON schema as input and generates test data matching the specification. You can download it from RubyGems:
```ruby
gem install json_test_data
```
Alternatively, it can be included in your Gemfile:
```ruby
gem "json_test_data", "~> 1.2.0"
```
To use it, first require it, then generate the test data using:
```ruby
data = JsonTestData.generate!(schema)
```
If you would prefer to return a Ruby object instead of a JSON object, simply include the `:ruby` option:
```ruby
data = JsonTestData.generate!(schema, ruby: true)
```

The input that you put into it must be valid [JSON schema](http://json-schema.org). The top-level object must have a `:type` key indicating the type of object to be generated ("object", "array", "string", etc.).

## Contribute
The JSON Test Data Generator is in its infancy and contributions are much appreciated. Please include passing tests with all pull requests, and file an issue report indicating what you'd like to work on. I'm also happy to get issue reports that do not come with pull requests, but can't guarantee I'll actually write whatever it is you want JSON Test Data to do. I strongly encourage pull requests adding documentation!
