Given(/the following JSON schema:$/) do |schema|
  @schema = schema
end

When(/^I run the JSON data generator$/) do
  @output = JsonTestData.generate!(@schema)
end

Then(/^the JSON output should be:$/) do |json|
  expect(@output).to eq json
end

Then(/^the "([^"]*)" property of the JSON output should be a (.*)$/) do |prop, type|
  klass = Class.const_get(type)
  expect(JSON.parse(@output).fetch(prop).class).to eql klass
end
