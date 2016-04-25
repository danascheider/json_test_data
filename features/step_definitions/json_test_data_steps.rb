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

Then(/^the output should be a Ruby hash$/) do
  expect(@output).to be_a(Hash)
end

Then(/^the output should be a Ruby array$/) do
  expect(@output).to be_a(Array)
end
