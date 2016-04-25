Given(/the following JSON schema:$/) do |schema|
  @schema = schema
end

When(/^I run the JSON data generator$/) do
  @output = JsonTestData.generate!(@schema)
end

When(/^I run the JSON data generator with the "ruby" option$/) do
  @output = JsonTestData.generate!(@schema, ruby: true)
end

Then(/^the output should match the schema$/) do
  expect(@output).to match_schema(@schema)
end

Then(/^the JSON output should be:$/) do |json|
  expect(@output).to eq json
end

Then(/^the output should be a Ruby hash$/) do
  expect(@output).to be_a(Hash)
end

Then(/^the output should be a Ruby array$/) do
  expect(@output).to be_a(Array)
end

Then(/^the output array should have (\d+) items$/) do |count|
  arr = JSON.parse(@output)
  expect(arr.size).to eql count.to_i
end

Then(/^the "([^" ]*)" property of the JSON output should be a ([^ ]*)$/) do |prop, type|
  klass = Class.const_get(type)
  expect(JSON.parse(@output).fetch(prop).class).to eql klass
end

Then(/^the "([^"]*)" property of the JSON output should be a string of length (\d+)$/) do |prop, length|
  expect(JSON.parse(@output).fetch(prop).class).to eql String
  expect(JSON.parse(@output).fetch(prop).length).to eql length.to_i
end

Then(/^the output array should have no duplicate items$/) do
  output = JSON.parse(@output)
  expect(output.uniq).to eq output
end

Then(/^the "([^"]*)" key in the output hash should have a numeric value$/) do |key|
  output = JSON.parse(@output)
  expect(output.fetch(key)).to be_a Numeric
end

Then(/^the output should be an array of numbers$/) do
  expect(JSON.parse(@output)).to be_a Array
  expect(JSON.parse(@output).all? {|n| n.is_a? Numeric }).to be true
end

Then(/^JSON output should have (\d+) properties$/) do |number|
  expect(JSON.parse(@output).length).to eql number.to_i
end
